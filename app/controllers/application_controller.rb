class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "National Parks Finder" }.to_json
  end

  get "/parks" do 
    parks = Park.all
    parks.to_json
  end
  
  get "/parks/:id/activities" do 
    park = Park.find(params[:id])
    activities = park.activities
    activities.to_json
  end

  get "/parks/:id/reviews" do
    #inner join
    joined = User.joins(:reviews).select('users.*,reviews.*').where('reviews.park_id == ' + params[:id]) 
    joined.to_json
  end

  get "/reviews" do
    joined = User.left_outer_joins(:reviews).select('users.*,reviews.*')
    joined.to_json
  end

#####################################
#  HERE IS THE COMBINED SEARCH FILTER
#####################################

  get "/parks/search/:searchString" do
    search_string = params[:searchString]

    search_array = search_string.split("&")

    state_searched = ""
    name_searched = ""
    activities_searched = ""

    search_array.each do |x|
      if x.include? "S="
        state_searched = search_array.filter { |x| x.include? "S=" }[0]
        state_searched.slice! "S="
      elsif x.include? "N="
        name_searched = search_array.filter { |x| x.include? "N=" }[0]
        name_searched.slice! "N="
      
      elsif x.include? "A="
        activities_searched = search_array.filter { |x| x.include? "A=" }[0]
        activities_searched.slice! "A="
      end
    end

    #filter by name and state
    results_name_state = Park.where(["name LIKE ? and state LIKE ?", "%"+name_searched+"%", "%"+state_searched+"%"])

    #filter the name and state results by activities
    if activities_searched != ""
      
      activ_arr = activities_searched.split(",")
      results = []
      
      results_name_state.each do |p| #for each park object
        if activ_arr - p.activities.map { |a| a.name } == [] 
          results << p
        end  
      end 

    else
      results = results_name_state
    end

   results.to_json
    
  end


###################################
# Post, Delete, and Edit Reviews 
###################################

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
      review_text: params[:review_text]
    )
    review.to_json
  end


end
