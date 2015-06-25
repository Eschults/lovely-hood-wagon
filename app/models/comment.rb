class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :activity

  validates_presence_of :content, :user
  acts_as_votable
end
