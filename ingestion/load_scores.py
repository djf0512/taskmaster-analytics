import duckdb

con = duckdb.connect("warehouse/taskmaster.duckdb")
con.execute("create schema if not exists raw")

base = "data/raw/taskmaster-uk-scores/data"
for table in ["scores_long", "tasks", "episodes"]:
    con.execute(f"""
        create or replace table raw.{table} as
        select * from read_csv_auto('{base}/{table}.csv')
    """)
    n = con.execute(f"select count(*) from raw.{table}").fetchone()[0]
    print(f"raw.{table}: {n} rows")
