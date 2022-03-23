class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  get "/parks" do 
    parks = Park.all
    parks.to_json
  end

  get "/parks/filter/:activ_str" do
    activ_arr = params[:activ_str].split(",")
    parks = Park.all
    results = []
    parks.each do |p| #for each park object
      if activ_arr - p.activities.map { |a| a.name } == [] 
        results << p
      end  
    end 

   #trying to end up with an array of parks objects
   #parks.first.activities.to_json 
   results_names = results.map { |r| r.name }
   results_names.to_json
  end

  get "/parks/state/:locationString" do
    state = params[:locationString]
    parks = Park.all
    results = parks.where(state: state)
    results.to_json
  end

#####################################
#  HERE IS THE COMBINED SEARCH THING
#####################################

  get "/parks/search/:searchString" do
    search_string = params[:searchString]

    search_array = search_string.split("&")

    state_searched = ""
    name_searched = ""

    # Doing it the long way because if these params aren't there we need to keep the variables = ""
    search_array.each do |x|
      if x.include? "S="
        state_searched = search_array.filter { |x| x.include? "S=" }[0]
        state_searched.slice! "S="
      elsif x.include? "N="
        name_searched = search_array.filter { |x| x.include? "N=" }[0]
        name_searched.slice! "N="
      end
    end


    
    #state_searched = search_array.filter { |x| x.include? "S=" }[0]
   # name_searched = search_array.filter { |x| x.include? "N=" }[0]

   # return state_searched.to_json

    #state_searched.slice! "S="
    

   # name_searched.slice! "N="

    parks = Park.all
    results = Park.where(["name LIKE ? and state LIKE ?", "%"+name_searched+"%", "%"+state_searched+"%"])

   results.to_json

  end


 


  get "/parks/:id/activities" do 
    park = Park.find(params[:id])
    activities = park.activities
    activities.to_json
  end

  get "/parks/:id/reviews" do
    park = Park.find(params[:id])
    reviews = park.reviews
    reviews.to_json
  end


  get "/reviews" do
    reviews = Review.all
    reviews.to_json
  end

  post "/reviews" do
    review = Review.create(
      park_id: params[:park_id],
      user_id: params[:user_id],
      likes: params[:likes],
      review_text: params[:review_text]
    )
    review.to_json
  end

  delete "/reviews/:id" do 
    review = Review.find(params[:id])
    review.destroy
    review.to_json
  end

  patch "/reviews/:id" do
    review = Review.find(params[:id])
    review.update(
      likes: params[:likes]
    )
    review.to_json
  end


end
