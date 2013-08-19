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
  Section.create!(name: "Headlines", rank: 1, image_src: "../../assets/140x140.png")
  Section.create!(name: "US News", rank: 2, image_src: "../../assets/140x140.png")
  Section.create!(name: "World News", rank: 3, image_src: "../../assets/140x140.png")
  Section.create!(name: "Politics", rank: 4, image_src: "../../assets/140x140.png")
  Section.create!(name: "Local", rank: 5, image_src: "../../assets/140x140.png")
  Section.create!(name: "Business", rank: 6, image_src: "../../assets/140x140.png")
  Section.create!(name: "Opinion", rank: 7, image_src: "../../assets/140x140.png")
  Section.create!(name: "Science", rank: 8, image_src: "../../assets/140x140.png")
  Section.create!(name: "Technology", rank: 9, image_src: "../../assets/140x140.png")
  Section.create!(name: "Health", rank: 10, image_src: "../../assets/140x140.png")
  Section.create!(name: "Sports", rank: 11, image_src: "../../assets/140x140.png")
  Section.create!(name: "Arts and Culture", rank: 12, image_src: "../../assets/140x140.png")
  Section.create!(name: "Entertainment", rank: 13, image_src: "../../assets/140x140.png")
  Section.create!(name: "Lifestyle", rank: 14, image_src: "../../assets/140x140.png")
  Section.create!(name: "Travel", rank: 15, image_src: "../../assets/140x140.png")
  Section.create!(name: "Cooking", rank: 16, image_src: "../../assets/140x140.png")
  Section.create!(name: "Photography", rank: 17, image_src: "../../assets/140x140.png")
  Section.create!(name: "Humor", rank: 18, image_src: "../../assets/140x140.png")
  Section.create!(name: "Books", rank: 19, image_src: "../../assets/140x140.png")
  Section.create!(name: "Crosswords and Puzzles", rank: 20, image_src: "../../assets/140x140.png")
  Section.create!(name: "Inspirational", rank: 21, image_src: "../../assets/140x140.png")
  
end

def make_feeds
  sections = Section.all(limit: 6)
  10.times do
    name = Faker::Lorem.sentence(3)
    description = Faker::Lorem.sentence(20)
    url = "http://food52.tumblr.com/rss"
    image_src = "../../assets/140x140.png"
    sections.each { |section| section.feeds.create!(name: name, description: description, url: url, image_src: image_src) }
  end #50 times
end

def make_relationships
  admin_user  = User.first
  all_feeds = Feed.all
  followed_feeds = all_feeds[2..20]
  followed_feeds.each { |followed| admin_user.follow!(followed) }
end