require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    if User.find_by(email: params[:email], password: params[:password]) != nil
      @user = User.find_by(email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/account'
    else
      erb :error
    end
  end

  get '/account' do
    @user = Helper.current_user(session)
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


end
