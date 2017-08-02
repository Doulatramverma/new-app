class Blog < ApplicationRecord
 mount_uploader :avatar, AvatarUploader
  belongs_to :user , optional: true
 acts_as_votable
 has_many :comments
    
end
