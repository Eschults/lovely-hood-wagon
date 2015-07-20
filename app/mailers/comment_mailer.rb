class CommentMailer < ActionMailer::Base
  default from: '"Lovely Hood" <contact@lovely-hood.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comment_mailer.new_comment.subject
  #
  def new_comment(comment)
    @comment = comment

    mail to: @comment.post.user.email, subject: "#{@comment.user.first_name} a commenté votre post"
  end
end
