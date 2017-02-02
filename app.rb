require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'sequel'

use Rack::Session::Cookie,
  :expire_after => 3600,
  :secret => 'change'


options = {:encoding=>"utf8"}
db_path = File.dirname(__FILE__). + "/db/db.db"

DB = Sequel.sqlite(db_path)

get '/' do
  @members = DB[:user]
  @title = "rootpage"
  erb :index
end

post '/' do
  @members = DB[:user]
  @title = "rootpage"
  session[:userID] = params[:userID]
  session[:userName] = params[:username]
  erb :index

end

get '/login' do
    @members = DB[:user]
    @title = "loginpage"
    erb :login
end

post '/logout' do
  @members = DB[:user]
  @title = "logout"
  session[:userID] = ""
  session[:userName] = ""
  erb :index
end
