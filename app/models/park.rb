class Park < ActiveRecord::Base
    has_many :parks_activities 
    has_many :activities, through: :parks_activities #
    has_many :reviews
    has_many :users, through: :reviews
end