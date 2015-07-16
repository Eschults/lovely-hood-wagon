class PostMailer < ActionMailer::Base
  default from: '"Lovely Hood" <contact@lovely-hood.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.post.subject
  #
  def lh_post(post)
    @post = post

    mail to: "contact@lovely-hood.com", bcc: "#{User.lh_post_emails_in_string}", subject: "LH a publié un post sur le Wall"
  end

  def post(post)
    @post = post

    mail to: "contact@lovely-hood.com", bcc: "#{post.user.post_emails_in_string}", subject: "#{post.user.first_name} a publié un post sur le Wall"
  end

  def like(post, liker)
    @post = post
    @liker = liker

    mail to: post.user.email, subject: "#{@liker.first_name} aime votre post"
  end

  def comment(post, commenter)
    @post = post
    @commenter = commenter

    mail to: post.user.email, subject: "#{@commenter.first_name} a commenté votre post"
  end
end
