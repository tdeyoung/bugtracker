json.array!(@users) do |user|
  json.extract! user, :id, :fname, :lname, :email, :thumbnail
  json.url user_url(user, format: :json)
end
