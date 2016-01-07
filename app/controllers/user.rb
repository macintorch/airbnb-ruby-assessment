get '/' do
  erb :"static/index"
end

post '/login' do
	@user = User.find_by_email(params[:user][:email])
	if @user.authenticate(params[:user][:password])
		session['user_id'] = @user.id
		redirect'/'
	else
		"Sorry. No user found."
	end
end

get '/users/:id/show' do
	@user = User.find(params[:id])
	erb :'users/show'
end

get '/users/:id' do
	@user = User.find(params[:id])
	erb :'users/show'
end

patch '/users/:id' do
  user = User.find(params[:id])
  user.update(name: params[:name], email: params[:email])
  redirect "/users/#{user.id}"
end

post '/signup' do
	
	user = User.new(params[:user])
	user.save
	redirect'/'
end

get '/users/:id/update' do
	@user = User.find(params[:id])
	erb :"users/edit"
end

post '/update' do
	@user = User.find_by_email(params[:id])
	@user.update(name: params[:name], email: params[:email])
	redirect to "/users/#{user.id}"
end

get '/logout' do
	session['user_id'] = nil
	"You are successfully logged out."
	erb :"static/index"
end