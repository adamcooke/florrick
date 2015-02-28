module Florrick
  class Railtie < Rails::Railtie

    initializer 'florrick.initialize' do
      ActiveSupport.on_load(:active_record) do
        require 'florrick/active_record_extension'
        ActiveRecord::Base.send :include, Florrick::ActiveRecordExtension
      end
    end

  end
end
