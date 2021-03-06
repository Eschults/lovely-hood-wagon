json.extract! conversation, :id, :user1, :user2, :updated_at, :created_at

json.picture (conversation.other_user(current_user).picture_file_name && conversation.other_user(current_user).picture_file_name != "") ? conversation.other_user(current_user).picture.url(:medium) : asset_path("user_pic-60.png")
json.first_name conversation.other_user(current_user).first_name
json.last_content auto_link(conversation.messages.sort_by(&:created_at).last.content, html: {target: "_blank"})
json.read conversation.messages.sort_by(&:created_at).last.read_at ? true : false
json.last_message_created_at l(conversation.messages.sort_by(&:created_at).last.created_at, format: "%e %b")
json.is_last_message_sender_current_user conversation.messages.sort_by(&:created_at).last.writer == current_user ? true : false
json.is_selected_conversation @conversation.id == conversation.id