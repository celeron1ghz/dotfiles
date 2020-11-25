DATA={{ lib_dir }}/{{ project }}/sql/serial_sql.txt

echo "data: $DATA"

psql -U {{ pg_username }} {{ pg_database }} < $DATA

