class ParksActivity < ActiveRecord::Base
    belongs_to :park
    belongs_to :activity
end