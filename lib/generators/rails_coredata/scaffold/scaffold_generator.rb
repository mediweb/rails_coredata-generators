require 'generators/rails_coredata'

module RailsCoredata
  module Generators
    class ScaffoldGenerator < NamedBase

      invoke 'rails_coredata:model'
      invoke 'rails_coredata:controller'
      invoke 'rails_coredata:serializer'

    end
  end
end
