class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates_presence_of :user, :content
end
