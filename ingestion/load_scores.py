import duckdb

con = duckdb.connect("warehouse/taskmaster.duckdb")
con.execute("create schema if not exists raw")
con.execute("""
    create or replace table raw.scores_long as
    select * from read_csv_auto('data/raw/taskmaster-uk-scores/data/scores_long.csv')
""")
print(con.sql("select count(*) as n from raw.scores_long"))
print(con.sql("select * from raw.scores_long limit 5"))
