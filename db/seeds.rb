# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
1_000.times do
  Course.create!(
    title: Faker::Company.bs,
    minutes: Faker::Number.number(digits: 2),
    published: [true, true, true, true, false].sample,
    slides: 5.times.map do |i|
      Slide.new(
        content: Faker::Hacker.say_something_smart,
        order: i
      )
    end
  )
end