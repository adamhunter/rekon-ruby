module Rekon
  module App
    extend ActiveSupport::Autoload
    
    autoload :Installer
    
    Ripple.client.http_backend = :Excon
    
    def self.install!
      return false if Rekon::App::Installer.installed?
      Rekon::App::Installer.install!
    end

  end
end