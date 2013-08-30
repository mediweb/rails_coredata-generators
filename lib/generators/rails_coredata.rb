require 'rails/generators/base'
require 'rails/generators/named_base'
require 'core_data'

module RailsCoredata
  module Generators
    class NamedBase < Rails::Generators::NamedBase
      remove_argument :name
      argument :path, :type => :string, :banner => 'path/to/data.xcdatamodeld'

      TYPE_MAP = {
                   "Boolean" => 'boolean',
                   "Date" => 'datetime',
                   "Integer 32" => 'integer',
                   "String" => 'string',
                 }

      def initialize(args, *options) #:nodoc:
        self.name = 'NOT_USED' # FIXME Workaround for error with remove_argument :name
        @orm_class = Rails::Generators::ActiveModel
        super
        ensure_coredata_file
        @coredata_schema = CoreData::DataModel.new(path)
        @entities = @coredata_schema.entities
      end

      def self.source_root
        @_rails_coredata_source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'rails_coredata', generator_name, 'templates'))
      end

      protected
        # Override
        def table_name
          @current_entity.name.tableize
        end

      private
        def ensure_coredata_file
          if File.exists?(path) && path =~ /xcdatamodeld$/
            say("Loaded #{path} xcdatamodeld file", :blue)
          else
            say_status("error", "Cannot load xcdatamodeld file: [#{path}]", :red)
            raise Thor::Error
          end
        end

        def with_each_entity
          @entities.each do |entity|
            @current_entity = entity
            assign_names!(entity.name)
            # Clear all cached instance variables
            @table_name = @singular_table_name = @plural_table_name = @plural_name = @file_path = @human_name = @i18n_scope = @namespaced_class_path = @namespaced_file_path = @plural_file_name = @route_url = nil
            yield entity
          end
        end

    end
  end
end
