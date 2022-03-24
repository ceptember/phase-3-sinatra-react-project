require 'open-uri'
require 'net/http'
require 'json'
require 'faker'


#####
# Note remember to use bundle exec rake db:seed:replant
#####

### NOTE - DELETE THIS AUTH KEY BEFORE PUSHING TO GH
url = ""
uri = URI.parse(url)
response = Net::HTTP.get_response(uri)
parsed = JSON.parse(response.body)

puts "🌱 Seeding spices..."

# Seed your database here



# SEED THE PARKS TABLE 
park_hashes = []

parsed["data"].each do |park| 
    park_hash = { name: park["fullName"],
    description: park["description"],
    url: park["url"],
    city: park["addresses"][0]["city"],
    state: park["addresses"][0]["stateCode"],
    lat: park["latitude"],
    long: park["longitude"],
    }

    park_hashes << park_hash
end 

Park.create(park_hashes)

# SEED THE ACTIVITIES TABLE

categories = [
    {
        name: "water",
        items: ["Paddling", "Canoeing", "Kayaking", "Stand Up Paddleboarding", "Sailing", "Swimming", "Freshwater Swimming","Saltwater Swimming","SCUBA Diving","Snorkeling","Surfing","Jet Skiing", "Water Skiing","Motorized Boating","Whitewater Rafting","River Tubing","Tubing","Pool Swimming","Boating"]
    },
    {
        name: "culture",
        items: ["Arts and Culture", "Cultural Demonstrations","Park Film","Live Music","Theater","Arts and Crafts","Craft Demonstrations"]
    },
    {
        name: "camping",
        items:  ["Camping", "Group Camping", "Canoe or Kayak Camping","Car or Front Country Camping", "RV Camping","Backcountry Camping"]
    },
    {
        name: "climbing",
        items: ["Climbing","Rock Climbing","Mountain Climbing","Ice Climbing"]
    },
    {
        name: "astronomy",
        items: ["Astronomy", "Stargazing", "Planetarium"]
    },
    {
        name: "food and shopping",
        items: ["Food","Picnicking","Dining","Shopping", "Bookstore and Park Store","Gift Shop and Souvenirs"]
    },
    {
        name: "biking",
        items: ["Biking","Mountain Biking","Road Biking"]
    },
    {
        name: "fishing and hunting",
        items: ["Fishing", "Freshwater Fishing","Fly Fishing","Saltwater Fishing", "Hunting and Gathering", "Hunting"]
    },
    {
        name: "tours",
        items: ["Guided Tours","Self-Guided Tours - Auto","Bus/Shuttle Guided Tour","Boat Tour"]
    },
    {
        name: "hiking",
        items: ["Hiking","Front-Country Hiking","Backcountry Hiking","Off-Trail Permitted Hiking"]
    },
    {
        name: "horse",
        items: ["Horse Trekking","Horseback Riding","Horse Camping (see also Horse/Stock Use)","Horse Camping (see also camping)"]
    }, 
    {
        name: "snow",
        items: ["Skiing","Cross-Country Skiing","Downhill Skiing", "Snow Play","Snowmobiling","Snowshoeing","Snow Tubing","Dog Sledding","Ice Skating"]
    },
    {
        name: "historical",
        items: ["Living History","First Person Interpretation","Self-Guided Tours - Walking","Museum Exhibits","Historic Weapons Demonstration","Reenactments"]
    }, 
    {
        name: "automotive",
        items: ["Auto and ATV", "Scenic Driving", "Auto Off-Roading","ATV Off-Roading"]
    }, 
    {
        name: "wildlife",
        items: ["Wildlife Watching","Birdwatching"]
    }, 
    {
        name: "flying",
        items: ["Flying", "Fixed Wing Flying","Helicopter Flying"]
    }, 
    {
        name: "kids", 
        items: ["Junior Ranger Program","Playground"]
    }, 
    {
        name: "other", 
        items: ["Mini-Golfing","Golfing","Team Sports","Canyoneering","Caving","Hands-On","Citizen Science","Volunteer Vacation","Orienteering","Compass and GPS","Geocaching","Gathering and Foraging"]
    }
]

  activity_hashes = []

  categories.each do |cat|
    cat[:items].each do |item|
      act_hash = {
        name: item,
        category: cat[:name]
      }
      activity_hashes << act_hash
    end
  end

  Activity.create(activity_hashes)


  # SEED USERS TABLE 
50.times do 
    name = Faker::Name.name 
    while name[" "] do
        name[" "] = "_"
    end 

    if name["."]
        name["."] = ""
    end

    if name["'"]
        name["'"] = ""
    end

    email = name + "@examplefakedomain.com"
    User.create(
        {
            user_name: name,
            user_email: email
        }
    )
end


#SEED PARKS ACTIVITIES 

parks_activities = []

parsed["data"].each do |park|
    park["activities"].each do |act|
        name = act["name"]
        activity = Activity.find_or_create_by(name: name) #id
        p = Park.find_or_create_by(name: park["fullName"]) 
        ParksActivity.create(
            {
                park_id: p.id,
                activity_id: activity.id
            }
        )

 
    end
end


#SEED REVIEWS

sentence1 = ["Wow!!! ", "Amazing! ", "", "", "", "OMG! ", "Meh. ", "uhh... "]
sentence2 = ["", "I visited once. ", "I went there years ago. ", "", "", "I've been so many times. ", "I live here now. ", "My regular party spot. "]
sentence3 = ["",  "I saw a duck. ", "", "I saw a cat. ", "", "I saw a squirrel. ", "There were trees. ", "So many stars! "]
sentence4 = ["I loved it!", "So cool!", "It was amazing!!", "It was great!", "Can't wait to come back.", "Glad to be home.", "This was weird.", "So, yeah..."]

900.times do 
    body = sentence1.sample + sentence2.sample + sentence3.sample + sentence4.sample
    
    Review.create(
        park_id: rand(Park.minimum("id")..Park.maximum("id")),
        user_id: rand(User.minimum("id")..User.maximum("id")),
        review_text: body, 
        likes: 0
    )
end 


puts "✅ Done seeding!"


