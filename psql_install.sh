sudo apt update
sudo apt install postgresql postgresql-contrib
sudo -u postgres createuser -s -i -d -r -l -w focus
sudo -u postgres psql -c "ALTER ROLE focus WITH PASSWORD 'start';"
sudo -u postgres psql -c '\x' -c "CREATE DATABASE focus_start;"
sudo -u postgres psql -c '\x' -c "GRANT ALL ON DATABASE focus_start TO focus;"

sudo -u postgres psql -f create_tables.sql focus_start
sudo -u postgres psql -f func_is_more_average.sql focus_start

