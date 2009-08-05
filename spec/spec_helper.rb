require 'spec'
require 'rubygems'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'active_record'
require 'dirty_callbacks'

Spec::Runner.configure do |config|
  config.mock_with :mocha
end

ActiveRecord::Base.configurations = {'sqlite3' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('sqlite3')

ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.logger.level = Logger::WARN

ActiveRecord::Schema.define(:version => 0) do
  create_table :users do |t|
    t.string  :email,    :default => ''
  end
end

class User < ActiveRecord::Base
  include DirtyCallbacks
end

