# RedshiftCopier

The redshift_copier gem can be used to copy a single CSV file or a collection of files in S3 into Redshift.  If you would like to move data from one Redshift cluster to another, see the [redshift_extractor gem](https://github.com/MrPowers/redshift_extractor/).

## Copying without a manifest file

Here is how to use the redshift_copier gem to copy file(s) without a manifest file.

```ruby
db_config = {
  user: "some user",
  password: "password",
  host: "host",
  sslmode: 'require',
  port: 5439,
  dbname: "database name"
}
args = {
  schema: "schema name",
  table: "table name",
  create_sql: File.read("path to create.sql file"),
  aws_access_key_id: "aws_access_key_id",
  aws_secret_access_key: "aws_secret_access_key",
  s3_path: "s3://some_bucket/some_file.csv",
  db_config: db_config,
  copy_command_options: "dateformat 'auto' timeformat 'auto' blanksasnull emptyasnull escape removequotes delimiter ',' ignoreheader 1;"
}
copier = RedshiftCopier::Copy.new(args)
copier.run
```

The `copy_command_options` need to be updated depending on your data.  For example, if your CSV file does not have a header row, the `ignoreheader 1` option should be removed.

To copy a collection of files, set the `s3_path` to a folder: `"s3://some_bucket/some_folder/"`.  All the files in the folder will be copied and they all must have the same CSV structure.

## Copying with a manifest file

Copying a collection of files is similar to copying a single file, but it requires a manifest file.

```json
{
  "entries": [
    {"url":"s3://some_bucket/some_folder/0000_part_00.gz"},
    {"url":"s3://some_bucket/some_folder/0001_part_00.gz"}
  ]
}
```

The path to the manifest file must be set in `s3_path` and the `copy_command_options` must specify the manifest option.

```ruby
args = {
  schema: "schema name",
  table: "table name",
  create_sql: File.read("path to create.sql file"),
  aws_access_key_id: "aws_access_key_id",
  aws_secret_access_key: "aws_secret_access_key",
  s3_path: "s3://some_bucket/some_folder/manifest",
  db_config: db_config,
  copy_command_options: "manifest dateformat 'auto' timeformat 'auto' blanksasnull emptyasnull escape gzip removequotes delimiter '|';"
}
copier = RedshiftCopier::Copy.new(args)
copy.run
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redshift_copier'
```

And then execute:

    $ bundle

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MrPowers/redshift_copier.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

