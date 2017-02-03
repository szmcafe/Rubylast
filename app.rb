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
  @members = DB
  @title = "rootpage"
  erb :index
end

post '/' do
      @members = DB
      @title = "rootpage"
      begin
        name = DB[:user].where(userID: params[:userID]).first
      if name[:userID] == params[:userID] then
        session[:userID] = CGI.escapeHTML(params[:userID])
        session[:userName] = CGI.escapeHTML(params[:userName])
        erb :index
      end
      rescue
        redirect back
      end

end

get '/login' do
    @members = DB
    @title = "loginpage"
    erb :login
end

post '/logout' do
  @members = DB
  @title = "logout"
  session[:userID] = ""
  session[:userName] = ""
  erb :index
end
post '/tweet' do
  unless params[:tweet].empty?
    DB[:tweet].insert(nil,params[:userID],CGI.escapeHTML(params[:tweet]))

  end
end

get '/registration' do
  @title = "registration"
  erb :registration
end
post '/newmember' do
  begin
   unless params[:userID].empty? && params[:userName].empty?
       session[:userID] = CGI.escapeHTML(params[:userID])
       session[:userName] = CGI.escapeHTML(params[:userName])
       DB[:user].insert(session[:userID],session[:userName],"nil")
       redirect to('/')
   else
     redirect back
   end
  rescue
      redirect to('/login')
  end

end
