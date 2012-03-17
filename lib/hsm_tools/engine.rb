module HsmTools
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
    end
    initializer 'hsmtools.register_plugin', :after=>"HsmPlugins" do |app|
       Hsm::Application::Plugins.add "tools"
    end
  end
end
