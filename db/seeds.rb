puts 'Creating permissions for boss...'
permissions = [
  # Guest
  #{:action => "index", :subject_class => "home", :role_id => nil },
  # Member
  {:action => "read", :subject_class => "Boss::Post", :role_id => 1 },
  # Admin
  #{:action => "manage", :subject_class => "all", :role_id => 2 }
]

permissions.each do |attributes|
  Citygate::Permission.create attributes
end unless Citygate::Permission.find_by_action_and_subject_class_and_role_id("read","Boss::Post",1)

puts 'Creating categories for boss...'
categories = [
  {name: "Default"}
]

categories.each do |attributes|
  Boss::Category.find_or_create_by_name(attributes[:name])
end