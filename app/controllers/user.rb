get '/user/new' do
  erb :"user/new"
end

post '/user' do
  @user = User.new(params[:user])

  if @user.save
    session[:messages] = ["Please Sign In"]
    redirect "/"
  else
    redirect "/user/new"
  end
end

post '/authenticate' do
  @user = User.authenticate(params[:user])

  if @user
    session[:user_id] = @user.id
    redirect "/profile"
  else
    session[:messages] = ["Login Failed"]
    redirect "/"
  end

end

get '/profile' do
  if session[:user_id].nil?
    redirect "/"
  else
    @user = User.find(session[:user_id])
    @urls = @user.urls
    @errors = session[:errors]
    session[:errors] = nil
    erb :"user/profile"
  end
end

get '/logout' do
  session[:user_id] = nil
  session[:messages] = ["You are now logged out."]
  redirect "/"
end
