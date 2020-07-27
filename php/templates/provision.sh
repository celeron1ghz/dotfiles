
DATA1={{ lib_dir }}/{{ project }}/sql/master_data.txt
DATA2={{ lib_dir }}/{{ project }}/sql/master_data2.txt
DDL={{ lib_dir }}/{{ project }}/sql/createtable_posgresql.sql

echo "data: $DATA1, $DATA2"
echo "ddl:  $DDL"

echo "DROP DATABASE {{ pg_database }}; CREATE DATABASE {{ pg_database }};" | psql -U postgres

psql -U {{ pg_username }} {{ pg_database }} < $DDL
psql -U {{ pg_username }} {{ pg_database }} < $DATA1
psql -U {{ pg_username }} {{ pg_database }} < $DATA2
