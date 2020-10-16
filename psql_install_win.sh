createuser -U postgres focus
psql -h 127.0.0.1 -p 5432 -U postgres -c "ALTER ROLE focus WITH PASSWORD 'start';"
psql -h 127.0.0.1 -p 5432 -U postgres -c "CREATE DATABASE focus_start;"
psql -h 127.0.0.1 -p 5432 -U postgres -c "GRANT ALL ON DATABASE focus_start TO focus;"
psql -h 127.0.0.1 -p 5432 -U postgres -f create_tables.sql focus_start
psql -h 127.0.0.1 -p 5432 -U postgres -f func_is_more_average.sql focus_start
