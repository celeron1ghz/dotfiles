DATA={{ lib_dir }}/{{ project }}/sql/serial_sql.sql

echo "data: $DATA"

psql -U {{ pg_username }} {{ pg_database }} < $DATA

