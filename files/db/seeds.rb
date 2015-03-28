User.find_or_initialize_by(email: "developer@localhost.nl") do |user|
  user.password = "blablabla"
  user.save!
end
