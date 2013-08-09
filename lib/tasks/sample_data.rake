namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_sections
    make_feeds
    make_relationships
  end
end

def make_users
  admin = User.create!(first_name: "Savannah",
                 last_name: "Niles",
                 email: "savannahniles@gmail.com",
                 password: "password",
                 password_confirmation: "password",
                 admin: true)
  99.times do |n|
      first_name  = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(first_name: first_name,
                   last_name: last_name,
                   email: email,
                   password: password,
                   password_confirmation: password)
  end
end

def make_sections
  Section.create!(name: "Headlines")
  Section.create!(name: "Politics")
  Section.create!(name: "Science and Technology")
  Section.create!(name: "Opinion")
  Section.create!(name: "Lifestyle")
  Section.create!(name: "Cooking")
end

def make_feeds
  sections = Section.all(limit: 6)
  50.times do
    name = Faker::Lorem.sentence(3)
    description = Faker::Lorem.sentence(20)
    sections.each { |section| section.feeds.create!(name: name, description: description) }
  end #50 times
end

def make_relationships
  first_user  = User.first
  all_feeds = Feed.all
  followed_feeds = all_feeds[2..20]
  followed_feeds.each { |followed| first_user.follow!(followed) }
end