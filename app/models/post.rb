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
class Post < ActiveRecord::Base
  include PublicActivity::Common
  # tracked only: [:like, :like_activity, :update], owner: ->(controller, model) { controller && controller.current_user }

  belongs_to :user
  has_many :comments, dependent: :destroy

  has_attached_file :picture,
    styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :picture,
      content_type: /\Aimage\/.*\z/

  validates_presence_of :user, :content
  acts_as_votable

  def send_lh_post_email
    PostMailer.lh_post(self).deliver
  end

  def send_post_email
    PostMailer.post(self).deliver
  end

  def send_like_email(user)
    PostMailer.like(self, user).deliver
  end
end
