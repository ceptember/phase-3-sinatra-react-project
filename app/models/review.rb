class Review < ActiveRecord::Base
    belongs_to :park
    belongs_to :user
end