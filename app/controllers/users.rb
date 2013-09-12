# GET ============================
get '/user/:id' do
  erb :user
end

get '/logout' do
  session.clear

  redirect to "/"
end




# POST ============================

post '/login' do
   @user = User.find_by_email(params[:user][:email])
  p @user

  if @user && @user.authenticate(params[:user][:password])
    session[:user_id] = @user.id
    redirect to "/user/#{@user.id}"
  else
    @login_errors = "You have entered an invalid email or password."

    erb :index
  end
end

post '/create' do
  user = User.create(params[:user])
  if user.valid?
    session[:user_id] = user.id
  else
    @create_errors = "You must fill out the entire form and enter a valid email and matching password."
    erb :index
  end

  redirect to "/user/#{current_user.id}"
end