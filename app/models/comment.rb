class Comment < ApplicationRecord
  belongs_to :blog
  has_many :replies
end
