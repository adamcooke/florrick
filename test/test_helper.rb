require 'test/unit'
require 'date'
require 'time'
require 'florrick'

#
# Include Active Record and embed it
#
require 'active_record'
require 'florrick/active_record_extension'
ActiveRecord::Base.send :include, Florrick::ActiveRecordExtension

#
# Setup an active record database connection and create some tables for the
# test suite.
#
ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
ActiveRecord::Migration.create_table :users do |t|
  t.string :first_name, :last_name, :country_id, :fruit, :age, :date_of_birth, :time_of_birth, :place_of_birth
  t.timestamps
end
ActiveRecord::Migration.create_table :countries do |t|
  t.string :name, :currency
end

#
# Define a User model
#
class User < ActiveRecord::Base
  belongs_to :country
  florrick do
    string :first_name, :last_name, :age, :date_of_birth, :time_of_birth, :place_of_birth
    string(:full_name) { "#{first_name} #{last_name}" }
    string(:places) { ['London', 'Paris', 'New York', 'Poole'] }
    relationship :country
  end
end

#
# Define a Country model
#
class Country < ActiveRecord::Base
  has_many :users
  florrick do
    string :name, :currency
  end
end
