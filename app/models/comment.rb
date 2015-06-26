class Comment < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :post
  belongs_to :user

  validates_presence_of :content, :user
  acts_as_votable
end
