# Setup
Instructions for Windows (PowerShell). On macOS or Linux the same steps work with `source .venv/bin/activate` instead of the activation line, and forward slashes in paths.
> When you copy code from a web page or chat, do not copy the language label above the block (`python`, `powershell`, `sql`, `yaml`). A stray `python` as the first line of a script causes `NameError: name 'python' is not defined`.

## Table of Contents

- [1. Install tools (once)](#1-install-tools-once)
- [2. Get the project](#2-get-the-project)
- [3. Get the source data](#3-get-the-source-data)
- [4. Load and build](#4-load-and-build)
- [5. Explore the warehouse](#5-explore-the-warehouse)
- [Every time you open a terminal](#every-time-you-open-a-new-terminal)
- [Versions](#versions)
- [Troubleshooting](#troubleshooting)


## 1. Install tools (once)

```powershell
winget install Git.Git
winget install Python.Python.3.12
winget install Microsoft.VisualStudioCode
winget install DuckDB.cli
```

Close and reopen PowerShell and VS Code afterward. A terminal only sees programs installed before it started.

```powershell
git --version
python --version
duckdb -version
```

Use GitHub's private `noreply` address as your Git email (GitHub, Settings, Emails) so your own address is not in public commits:

```powershell
git config --global user.name "Your Name"
git config --global user.email "12345678+yourusername@users.noreply.github.com"
```

## 2. Get the project
Clone to a folder that is not inside OneDrive. Syncing can lock database files.

```powershell
mkdir C:\dev
cd C:\dev
git clone https://github.com/djf0512/taskmaster-analytics.git
cd taskmaster-analytics
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

If PowerShell says scripts are disabled, run `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` once and retry the activation.

## 3. Get the source data

```powershell
git clone https://github.com/silverdavi/taskmaster-uk-scores.git data\raw\taskmaster-uk-scores
```

The data is CC BY-SA 4.0 and is not part of this repository.

## 4. Load and build

From the repository root:

```powershell
python ingestion\load_scores.py
cd taskmaster_dbt
dbt build
```

`load_scores.py` rebuilds the `raw` tables each time and records the load time and the source commit. `dbt build` should finish with one warning (`warn_negative_episode_adjustments`, four known rows) and no errors.

## 5. Explore the warehouse

```powershell
duckdb warehouse\taskmaster.duckdb -ui
```

This opens a notebook in your browser. Useful SQL:

```sql
show all tables;
describe marts.fct_series_points;
select * from marts.fct_series_points where is_winner;
```

SQL only works inside DuckDB (a `D` prompt or a notebook cell). In PowerShell, `describe` runs an unrelated command and gives a confusing error.

dbt's own docs site, with the lineage graph:

```powershell
cd taskmaster_dbt
dbt docs generate
dbt docs serve
```

## Every time you open a new terminal

```powershell
cd C:\dev\taskmaster-analytics
.\.venv\Scripts\Activate.ps1
```

You should see `(.venv)` in the prompt. In VS Code you can select the `.venv` interpreter (Ctrl+Shift+P, "Python: Select Interpreter") so terminals activate it for you.

Prompt guide: `PS C:\...>` is PowerShell, `D` is the DuckDB shell, `>>>` is the Python interpreter.

## Versions
The DuckDB Python package, dbt-core, and dbt-duckdb are pinned in `requirements.txt`. There are two separate DuckDB installs: the Python package (used by the loader and dbt) and the command-line client (`duckdb`, used for exploring). A database file written by a newer DuckDB cannot be opened by an older one:

```
IO Error: Trying to read a database file with version number 69,
but we can only read versions between 64 and 68.
```

If you see this, `duckdb -version` is older than `pip show duckdb`. Fix it by upgrading the client (`winget upgrade --id DuckDB.cli`, or download the newest build from duckdb.org). The warehouse is rebuilt from the source CSVs, so it is safe to delete `warehouse\taskmaster.duckdb` and run step 4 again.

To update the pinned versions after upgrading packages, write the file as plain text. PowerShell's default `>` writes UTF-16, which GitHub and some tools cannot read:

```powershell
pip freeze | Out-File -Encoding ascii requirements.txt
```

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| `'dbt' is not recognized` | Virtual environment not active | Run the activation line from the repository root |
| `'duckdb' is not recognized` | Client not installed, or terminal opened before install | `winget install DuckDB.cli`, then reopen the terminal and VS Code |
| `database file with version number 69...` | Client older than the Python package | See Versions |
| Database is locked | A DuckDB shell or UI, or another script, has the file open | Close it and retry |
| `Cannot open file ...taskmaster_dbt\warehouse...` | Loader run from the wrong folder (older versions only) | Pull the latest code, which works from any folder |
| `source('raw', 'x') ... not found` | New raw table not declared | Add it to `models/staging/_sources.yml` |
| `NameError: name 'python' is not defined` | Code-block label pasted into the script | Delete that first line |
| Typing `exit` closed the terminal | `exit` ends a PowerShell session | Normal. Open a new terminal and reactivate `.venv` |
| A dbt test fails | Often a real data issue | Read the test name and row count. Do not silence it |