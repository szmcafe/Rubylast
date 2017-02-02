require 'sinatra'
require 'sinatra/reloader'
require 'sequel'

use Rack::Session::Cookie,
  :expire_after => 3600,
  :secret => 'change'


db_path = File.dirname(__FILE__). + "db.db"
DB = Sequel.sqlite(db_path)


get '/' do
  @title = "rootpage"
  erb :index
end

post '/' do
  session[:userID] = params[:userID]
  session[:userName] = params[:username]
  erb :index
end

get '/login' do
    @title = "loginpage"
    erb :login
end
