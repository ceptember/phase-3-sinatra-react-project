class Activity  < ActiveRecord::Base
    has_many :parks_activities
    has_many :parks, through: :parks_activities
end