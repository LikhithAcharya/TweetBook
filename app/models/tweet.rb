class Tweet < ActiveRecord::Base
   belongs_to :user
   has_many :comments
   has_many :tweet_categories
   has_many :categories, through: :tweet_categories


   default_scope { order(created_at: :desc)}
   
   validates :title, presence: true, length:{ minimum:3, maximum:50}
   validates :description, presence: true, length:{ minimum:5, maximum:300}
end
