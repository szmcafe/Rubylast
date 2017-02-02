require 'sinatra'
require 'sinatra/reloader'
require 'sequel'
db_path = File.dirname(__FILE__). + "db.db"
DB = Sequel.sqlite(db_path)


get '/' do
  @title = "rootpage"
  erb :index
end

post '/' do
  @user['name'] = params[:username]
  @user['userID'] = params[:userID]
  erb :index
end

get '/login' do
    @user = Hash.new()
    @title = "loginpage"
    erb :login
end
