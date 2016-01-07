get '/property/new' do
	@property = Property.all
  erb :'property/new'
end

#list of all properties
get '/property' do
	@user = User.find(session[:user_id])
	@property = Property.all
	erb :'property/index'
end

#create a new property
post '/property/new' do
	@user = current_user
    @property = @user.properties.new(title: params[:title], description: params[:description], price: params[:price])
   @property.save
   @property = Property.all
		erb :'property/index'
	
end

#display a property detail
get '/property/:id' do

  @property = Property.find(params[:id])
  @user = @property.user
  erb :'property/show'
end

#this to update a question
get '/property/:id/edit' do
	@property = Property.find(params[:id])
	erb :"pro/edit"
end

patch '/property/:id/edit' do
	property = Property.find(params[:id])
	property.update(params[:property])

	redirect "/property/#{property.id}"
end