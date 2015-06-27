class PostMailer < ActionMailer::Base
  default from: '"Lovely Hood" <contact@lovely-hood.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.post.subject
  #
  def post(post)
    @post = post

    mail to: "contact@lovely-hood.com", bcc: "#{User.all_emails_in_string}", subject: "LH a publié un post sur le Wall"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.like.subject
  #
  def like
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.comment.subject
  #
  def comment
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
