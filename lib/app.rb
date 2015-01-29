# cat config.ru
require "roda"

module App
  class User < Roda
    use Rack::Session::Cookie, :secret => 'hihohohooh'#ENV['SECRET']

    plugin :render, engine: 'haml'

    route do |r|
      r.is 'unauthorized' do
        response.status = 401
      end

      r.on 'profile' do
        r.redirect '/unauthorized' unless current_user
      end

      r.on 'login' do
        r.get do
          render 'login'
        end

        r.post do
          auth = Authenticator.new(request.params)
          if auth.valid?
            session[:user] = auth.account
            r.redirect 'logged'
          else
            r.redirect 'login'
          end
        end
      end

      r.on 'logged' do
        r.redirect '/unauthorized' unless current_user

        'You were logged in ' + current_user
      end

      r.on 'logout' do
        session[:user] = nil
        'User logged out'
      end
    end

    def current_user
      session[:user]
    end
  end

  class Authenticator
    attr_accessor :account

    def initialize(params)
      self.account = params['account']
      @password = params['password']
    end

    def valid?
      account == 'pepe' && @password == 'pepe'
    end
  end
end

