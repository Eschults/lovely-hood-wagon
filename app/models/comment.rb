module PublicActivity
  module ORM
    module ActiveRecord
      class Activity < ::ActiveRecord::Base
        acts_as_votable
        has_many :activity_comments
      end
    end
  end
end
class Comment < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :post
  belongs_to :user

  validates_presence_of :content, :user
  acts_as_votable
end
