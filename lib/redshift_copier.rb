require "redshift_copier/version"

require 'pg'

def require_all(pattern)
  root = File.expand_path("../", File.dirname(__FILE__))
  Dir.glob("#{root}/#{pattern}/**/*.rb").sort.each { |path| require path }
end

require_all("lib/redshift_copier")

module RedshiftCopier
end
