module RailsCoredata
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load File.join(File.dirname(__FILE__), '../tasks/templates.rake')
    end
  end
end
