module RedshiftCopier; class Copy

  attr_reader :schema, :table, :create_sql, :aws_access_key_id, :aws_secret_access_key, :s3_path, :db_config, :copy_command_options

  def initialize(args)
    @schema = args.fetch(:schema)
    @table = args.fetch(:table)
    @create_sql = args.fetch(:create_sql)
    @aws_access_key_id = args.fetch(:aws_access_key_id)
    @aws_secret_access_key = args.fetch(:aws_secret_access_key)
    @s3_path = args.fetch(:s3_path)
    @db_config = args.fetch(:db_config)
    @copy_command_options = args.fetch(:copy_command_options, "dateformat 'auto' timeformat 'auto' blanksasnull emptyasnull escape removequotes delimiter ',' ignoreheader 1;")
  end

  def run
    drop
    create
    copy
  end

  private

  def drop
    connection.exec(drop_sql)
  end

  def drop_sql
    "drop table if exists #{schema}.#{table};"
  end

  def create
    connection.exec(create_sql)
  end

  def copy_sql
    "copy #{schema}.#{table} from '#{s3_path}'"\
    " credentials '#{credentials}'"\
    " #{copy_command_options}"
  end

  def credentials
    "aws_access_key_id=#{aws_access_key_id};aws_secret_access_key=#{aws_secret_access_key}"
  end

  def copy
    connection.exec(copy_sql)
  end

  def connection
    PGconn.connect(db_config)
  end

end; end

