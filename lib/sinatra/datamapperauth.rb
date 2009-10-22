require 'sinatra/base'
require 'dm-core'
require 'dm-validations'
require 'date'
require 'digest/sha1'

module Sinatra
  module DataMapperAuth
    class User
      include DataMapper::Resource

      property :id, Serial
      property :login, String, :key => true, :length => (3..40), :nullable => false
      property :hashed_password, String
      property :email, String, :format => :email_address
      property :salt, String
      property :created_at, DateTime, :default => DateTime.now

      validates_present :login, :email
 
      def password=(pass)
        @password = pass
        self.salt = User.random_string(10) unless self.salt
        self.hashed_password = User.encrypt(@password, self.salt)
      end

      def self.encrypt(pass, salt)
        Digest::SHA1.hexdigest(pass + salt)
      end

      def self.authenticate(login, pass)
        u = User.first(:login => login)
        return nil if u.nil?
        return u if User.encrypt(pass, u.salt) == u.hashed_password
        nil
      end
      
      def self.random_string(len)
        chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
        str = ""
        1.upto(len) { |i| str << chars[rand(chars.size-1)] }
        return str
      end
    end
    module Helpers
      def authorized?
        return true if session[:user]
      end
      def authorize!
        redirect '/login' unless authorized?
      end
      def logout!
        session[:user] = false
      end
    end

    def self.registered(app)
      app.helpers DataMapperAuth::Helpers

      app.get '/login' do
        '<form action="/login" method="post">
          <p>Login</p><input type="text" size="30" name="login"/>
          <p>Password</p><input type="password" size="30" name="password"/>
          <br/>
          <input type="submit" value="Submit" name="submit"/>
        </form>'
      end

      app.post '/login' do
        if session[:user] = User.authenticate(params[:login], params[:password])
          flash[:notice] = "Login succesful"
          redirect '/'
        else
          flash[:notice] = "Login failed - Try again"
          redirect '/login'
        end
      end

      app.get '/logout' do
        logout!
        flash[:notice] = "Logged out"
        redirect '/'
      end
      
    end
  end

  register DataMapperAuth
end