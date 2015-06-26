module PublicActivity
  class Activity < inherit_orm("Activity")
    acts_as_votable
  end
end
class Post < ActiveRecord::Base
  include PublicActivity::Common
  # tracked only: [:like, :like_activity, :update], owner: ->(controller, model) { controller && controller.current_user }

  belongs_to :user
  has_many :comments, dependent: :destroy
  validates_presence_of :user, :content
  acts_as_votable

  def send_lh_post_email
    PostMailer.post(self).deliver
  end
end
