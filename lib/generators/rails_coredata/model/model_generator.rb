require 'generators/rails_coredata'

module RailsCoredata
  module Generators
    class ModelGenerator < NamedBase

      def generate_coredata_models
        with_each_entity do |entity|
          say("Executing generator for #{entity.name} model", :blue)
          generate build_command(entity)
        end
      end

      private
        def build_command(entity)
          cmd = "model #{entity.name}"
          attributes = entity.attributes.map{|a| "#{a.name.underscore}:#{TYPE_MAP[a.type]}"}
          relationships = entity.relationships.select{|r| r.to_one? }.map{|r| "#{r.name.underscore}:references" }
          ([cmd] + attributes + relationships).join(' ')
        end

    end
  end
end
