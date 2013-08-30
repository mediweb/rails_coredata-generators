require 'generators/rails_coredata'

module RailsCoredata
  module Generators
    class ControllerGenerator < NamedBase
      include Rails::Generators::ResourceHelpers

      def create_controller_files_and_add_routes
        # Controller
        with_each_entity do |entity|
          template 'controller.rb', File.join('app/controllers', class_path, "#{table_name}_controller.rb")
        end

        # Routes
        route_config = []
        with_each_entity do |entity|
          route_config << "resources :#{table_name}, except: [:new, :edit]"
        end
        route route_config.join("\n  ")
      end

      protected
        # Override method in Rails::Generators::ResourceHelpers
        def controller_class_name
          raise "Missing @current_entity!" if @current_entity.nil?
          @current_entity.name.pluralize
        end

    end
  end
end
