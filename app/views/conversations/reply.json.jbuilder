json.started_at t('.conversation_with', default: "Conversation avec") + " " + @conversation.other_user(current_user).first_name + " " + t('.started_on', default: "débutée le") + " " + l(@conversation.created_at, format: "%A %e %B à %Hh%M")
json.conversation_id @conversation.id
json.lastMessageId @conversation.messages.sort_by(&:created_at).last.id
json.firstName @conversation.other_user(current_user).first_name

json.conversations do
  json.array! @conversations do |conversation|
    json.partial! "conversations/conversation", conversation: conversation
  end
end

json.messages do
  json.array! @conversation.messages do |message|
    json.partial! "conversations/message", message: message
  end
end

json.write_a_reply t('.write_a_reply', default: "Votre réponse...")
json.submit t('.submit', default: "Envoyer")