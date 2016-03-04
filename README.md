# RedshiftCopier

The redshift_copier gem can be used to copy a single CSV file or a collection of files in S3 into Redshift.  If you would like to move data from one Redshift cluster to another, see the [redshift_extractor gem](https://github.com/MrPowers/redshift_extractor/).

## Copying a single file

Here is how to use the redshift_copier gem to copy a single file.

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

## Copying a collection of files

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redshift_copier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redshift_copier

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/redshift_copier.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

