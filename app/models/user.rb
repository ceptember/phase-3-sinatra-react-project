class User < ActiveRecord::Base
    has_many :reviews
    has_many :parks, through: :reviews
end