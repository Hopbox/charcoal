dbicdump -o dump_directory=./lib \
         -o components='["InflateColumn::DateTime"]' \
         -o debug=1 \
         -o overwrite_modifications=1 \
         Charcoal::Schema::PgDB \
         'dbi:Pg:dbname=charcoaldb;host=10.28.0.1;port=5433' \
         charcoal \
         charcoa1pa55
