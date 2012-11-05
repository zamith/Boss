puts 'Creating categories for boss...'
categories = [
  {name: "Default"}
]

categories.each do |attributes|
  Boss::Category.find_or_create_by_name(attributes[:name])
end