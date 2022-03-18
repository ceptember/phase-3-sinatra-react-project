require 'open-uri'
require 'net/http'
require 'json'

require 'faker'

puts Faker::Name.name 

return 

url = "https://developer.nps.gov/api/v1/parks?&limit=500&api_key=J0swua9odRTiY4Cl4HZPZ6vjzkgoSELSyisCq2wr"
uri = URI.parse(url)
response = Net::HTTP.get_response(uri)
parsed = JSON.parse(response.body)

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

#pp park_hashes

# ACTIVITIES AT EACH PARK FOR JOIN TABLE

#ParksActivity.create(park_id: 1)

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

return 
# This is an array of hashes with park name and activity name
# Need to look up park id and activity id and create a table with those 


 
 
#  park_id: parks.where(:name == park["fullName"])[:id],
#  activity_id: activities.where(:name == act["name"])[:id]

# ALL POSSIBLE ACTIVITIES (unique values)

activities = []

 parks_activities.each do |p_a| 
    if !activities.include? p_a[:activity]
        activities << p_a[:activity]
    end 
 end

#  pp activities
#  puts activities.count 
#  puts "unique down from"
#  puts parks_activities.count

 ## CATEGORIES of activities 

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


