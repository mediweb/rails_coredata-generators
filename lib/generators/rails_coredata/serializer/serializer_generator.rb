require 'generators/rails_coredata'

module RailsCoredata
  module Generators
    class SerializerGenerator < NamedBase

      def generate_coredata_serializers
        with_each_entity do |entity|
          say("Executing generator for #{entity.name} serializer", :blue)
          generate build_command(entity)
        end
      end

      private
        def build_command(entity)
          cmd = "serializer #{entity.name}"
          attributes = entity.attributes.map{|a| "#{a.name.underscore}:#{TYPE_MAP[a.type]}"}
          relationships = entity.relationships.select{|r| r.to_one? }.map{|r| "#{r.name.underscore}:references" }
          ([cmd] + attributes + relationships).join(' ')
        end

    end
  end
end
