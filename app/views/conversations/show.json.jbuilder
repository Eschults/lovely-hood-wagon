json.messages do
  json.array! @conversation.messages do |message|
    json.partial! "conversations/message", message: message
  end
end

json.conversations do
  json.array! @conversations do |conversation|
    json.partial! "conversations/conversation", conversation: conversation
  end
end