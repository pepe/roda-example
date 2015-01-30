require "roda"

=begin
  This main application module. As of now everything in the app is in this file.
  As this is only example I think it will stay that way.
=end
module App
  # Public: User part of the application
  class User < Roda
    use Rack::Session::Cookie, :secret => 'hihohohooh'#ENV['SECRET']

    # Slim segfaults on ruby_hooks FIXME: if you can
    plugin :render, engine: 'haml'

    # Routing of the request
    route do |r|
      # Here goes everything without user logged in
      r.is 'unauthorized' do
        response.status = 401
      end

      # Here is everything user needs when logged in
      r.on 'profile' do
        r.redirect '/unauthorized' unless session[:user]

        # Profile page
        r.is 'logged' do
          render 'logged'
        end

        # Logout page
        r.is 'logout' do
          session[:user]= nil
          render 'logout'
        end
      end

      # Users' login stuff
      r.is 'login' do
        # Show login form
        r.get do
          render 'login'
        end

        # Do auth and redirect on it
        r.post do
          auth = Authenticator.new(r['account'], r['password'])

          if auth.valid?
            session[:user] = auth.account
            r.redirect 'profile/logged'
          else
            r.redirect 'login'
          end
        end
      end
    end
  end

  # Internal: Authenticate service
  class Authenticator
    # Access to account
    attr_accessor :account

    # Takes password and account to initializa
    def initialize(account, password)
      self.account = account
      @password = password
    end

    # Returns true, if user can be authenticated
    def valid?
      account == 'pepe' && @password == 'pepe'
    end
  end
end

