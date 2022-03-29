# parkfinder

Parkfinder is a browser-based user interface for searching the U.S. national parks by name, location, and activities offered.   

## About

This project consists of two parts. This is the repository for the backend. The repository for the frontend can be found here: [https://github.com/ceptember/project-3-frontend](https://github.com/ceptember/project-3-frontend). 

## Installation and Setup

Fork and clone this project into your local environment. Navigate to the project folder in the command line, and run `bundle install`, which will install the dependencies listed in the Gemfile. Then run the command `bundle exec rake db:migrate` to create the tables. 

To fill your tables with data about the parks, you’ll need to get an API key from [https://www.nps.gov/subjects/developer/get-started.htm](https://www.nps.gov/subjects/developer/get-started.htm). Add this key to the `seeds.rb` file where it says `# <~~ YOUR API KEY`. 

NPS has issued the following statement on the use of this key: 

*“Keep your NPS API key private! Though it isn’t the end of the world, you don’t want to find out that your API calls are being throttled because someone else is using your API key to do something weird. So, don’t share your API key or accidentally publish it along with your code to a public repository somewhere like GitHub.”*

With the API key in the `seeds.rb` file, run the following from the command line: `bundle exec rake db:seed`. This will populate your database with data from the NPS API. Once your tables are filled with data, you can remove your API key from `seeds.rb`. 

Finally, run the command `rake server` from your command line. This will host the data on localhost:9292. 

Your backend is now set up. Note that the file `controllers/application_controller.rb` defines endpoints that make the data available to requests from the frontend. You can write additional queries in this file, and view the data by navigating, in your browser, to `localhost:9292/` followed by any of the routes defined in `application_controller.rb`. 

You will also need to separately clone and set up this project’s frontend repository [https://github.com/ceptember/project-3-frontend].

## Contributing and Modifying

Feel free to contribute to this project! There are many potential ways to expand this tool, such as additional search features, geographic data, maps, weather tools, etc. 

Likewise, you can also feel free to incorporate this tool, in whole or in part, into another (commercial or non-commercial) project. However, please provide attribution "By Christy Perozzi" and a link to this repository [https://github.com/ceptember/phase-3-sinatra-react-project] on anything you publish. 

## Resources

The database was seeded with data sourced from the [National Park Service API](https://www.nps.gov/subjects/developer/api-documentation.htm). The Ruby gem [ActiveRecord](https://rubygems.org/gems/activerecord) is used for object-relational mapping (creating models from the database). [Sinatra](http://sinatrarb.com/) is used to handle HTTP requests from the frontend and send back data from the ActiveRecord models .





