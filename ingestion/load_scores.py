"""Load the Taskmaster source CSVs into the raw schema of the local DuckDB warehouse.

Run it from anywhere:   python ingestion/load_scores.py

Every raw table gets two audit columns:
  _loaded_at      UTC time this load ran
  _source_commit  git commit of the source-data checkout, so a load can be traced to a data version
"""
import subprocess
from datetime import datetime, timezone
from pathlib import Path

import duckdb

REPO_ROOT = Path(__file__).resolve().parents[1]
DB_PATH = REPO_ROOT / "warehouse" / "taskmaster.duckdb"
SOURCE_DIR = REPO_ROOT / "data" / "raw" / "taskmaster-uk-scores"
DATA_DIR = SOURCE_DIR / "data"
TABLES = ["scores_long", "tasks", "episodes", "series"]


def source_commit() -> str:
    """Return the commit hash of the source-data checkout, or 'unknown' if it can't be read."""
    try:
        result = subprocess.run(
            ["git", "-C", str(SOURCE_DIR), "rev-parse", "HEAD"],
            capture_output=True, text=True, check=True,
        )
        return result.stdout.strip()
    except (subprocess.CalledProcessError, FileNotFoundError):
        return "unknown"


def main() -> None:
    missing = [t for t in TABLES if not (DATA_DIR / f"{t}.csv").exists()]
    if missing:
        raise SystemExit(
            f"Missing source files in {DATA_DIR}: {', '.join(m + '.csv' for m in missing)}\n"
            "Clone the source data first (see docs/setup.md)."
        )

    DB_PATH.parent.mkdir(parents=True, exist_ok=True)
    loaded_at = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S")
    commit = source_commit()

    con = duckdb.connect(str(DB_PATH))
    con.execute("create schema if not exists raw")
    for table in TABLES:
        csv_path = (DATA_DIR / f"{table}.csv").as_posix()
        con.execute(f"""
            create or replace table raw.{table} as
            select
                *,
                timestamp '{loaded_at}' as _loaded_at,
                '{commit}'              as _source_commit
            from read_csv_auto('{csv_path}')
        """)
        n = con.execute(f"select count(*) from raw.{table}").fetchone()[0]
        print(f"raw.{table}: {n} rows")
    print(f"loaded_at={loaded_at} UTC  source_commit={commit}")


if __name__ == "__main__":
    main()