class Category < ActiveRecord::Base
    has_many :tweet_categories
    has_many :tweets, through: :tweet_categories
    validates :name, presence: true, length: { minimum: 3, maximum: 25 }
    validates_uniqueness_of :name
end
