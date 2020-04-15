# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Project.delete_all

10.times do
  project = Project.new(
    title: Faker::ChuckNorris.unique.fact,
    description: Faker::Lorem.unique.paragraph_by_chars(number: 256),
    repo: Faker::Internet.unique.url(host: 'github.com'),
    site: Faker::Internet.unique.url(host: 'example.tech')
  )

  project.demo_image.attach(
    io: File.open(Rails.root.join('app', 'assets', 'images', 'placeholder.jpg')),
    filename: 'placeholder.jpg',
    content_type: 'image/jpeg'
  )

  project.toggle(:active)
  project.save
  if project.valid?
    puts 'PROJECT SAVED'
  else
    puts 'PROJECT NOT SAVED' if project.invalid?
    p project.errors.full_messages
  end
end
