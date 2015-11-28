json.neighbors do
  json.array! @users do |neighbor|
    json.partial! "users/neighbor", neighbor: neighbor
  end
end