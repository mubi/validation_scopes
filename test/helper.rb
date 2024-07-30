require 'minitest/autorun'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'validation_scopes'

puts "Testing against ActiveRecord #{ActiveRecord::VERSION::STRING}"

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => ":memory:"
)

require 'db/schema.rb'

Dir['./test/models/*.rb'].each { |f| require f }

require 'active_record/fixtures'

fixtures_dir = 'test/fixtures/'
fixture_files = Dir[File.join(fixtures_dir, "**/*.{yml}")]
  .reject { |f| f.start_with?(File.join(fixtures_dir, "files")) }
  .map { |f| f[fixtures_dir.to_s.size..-5].delete_prefix("/") }

ActiveRecord::FixtureSet.create_fixtures(fixtures_dir, fixture_files)

class TestCase < Minitest::Test; end
