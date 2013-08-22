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
  admin2 = User.create!(first_name: "Chris",
                 last_name: "Niles",
                 email: "cng8r@yahoo.com",
                 password: "password",
                 password_confirmation: "password",
                 admin: true) 
  10.times do |n|
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
  Section.create!(name: "Headlines", rank: 1, image_src: "140x140.png")
  Section.create!(name: "US News", rank: 2, image_src: "140x140.png")
  Section.create!(name: "World News", rank: 3, image_src: "140x140.png")
  Section.create!(name: "Politics", rank: 4, image_src: "140x140.png")
  Section.create!(name: "Local", rank: 5, image_src: "140x140.png")
  Section.create!(name: "Business", rank: 6, image_src: "140x140.png")
  Section.create!(name: "Opinion", rank: 7, image_src: "140x140.png")
  Section.create!(name: "Science", rank: 8, image_src: "140x140.png")
  Section.create!(name: "Technology", rank: 9, image_src: "140x140.png")
  Section.create!(name: "Health", rank: 10, image_src: "140x140.png")
  Section.create!(name: "Sports", rank: 11, image_src: "140x140.png")
  Section.create!(name: "Arts and Culture", rank: 12, image_src: "140x140.png")
  Section.create!(name: "Entertainment", rank: 13, image_src: "140x140.png")
  Section.create!(name: "Lifestyle", rank: 14, image_src: "140x140.png")
  Section.create!(name: "Travel", rank: 15, image_src: "140x140.png")
  Section.create!(name: "Cooking", rank: 16, image_src: "140x140.png")
  Section.create!(name: "Photography", rank: 17, image_src: "140x140.png")
  Section.create!(name: "Humor", rank: 18, image_src: "140x140.png")
  Section.create!(name: "Books", rank: 19, image_src: "140x140.png")
  Section.create!(name: "Crosswords and Puzzles", rank: 20, image_src: "140x140.png")
  Section.create!(name: "Inspirational", rank: 21, image_src: "140x140.png")
  
end

def make_feeds
  image_src = "fox_news.jpeg"

  #Headlines
    Section.find_by_id(1).feeds.create!(name: "Fox News: Latest Headlines", description: "Fox News: Fair and Balanced", url: "http://feeds.foxnews.com/foxnews/latest", site: "http://www.foxnews.com/index.html", image_src: image_src) 
    Section.find_by_id(1).feeds.create!(name: "Fox News: Happening Now", description: "The Happening Now blog provides you with behind-the-scenes, interaction with our hosts, and exclusive info on stories that didn't make it to air.", url: "http://feeds.foxnews.com/foxnews/happening-now", site: "http://www.foxnews.com/on-air/happening-now/index.html", image_src: image_src) 
 
  #US News
    Section.find_by_id(2).feeds.create!(name: "Fox News: US", description: "Fox News: Fair and Balanced", url: "http://feeds.foxnews.com/foxnews/national", site: "http://www.foxnews.com/us/index.html", image_src: image_src) 
    Section.find_by_id(2).feeds.create!(name: "Fox News Special Report with Bret Baier", description: "Special Report on Fox News Channel - follow host Bret Baier weeknights at 6pm ET.", url: "http://feeds.foxnews.com/foxnews/special-report", site: "http://www.foxnews.com/on-air/special-report-bret-baier/index.html", image_src: image_src) 
    Section.find_by_id(2).feeds.create!(name: "Fox News Sunday with Chris Wallace", description: "Fox News Sunday on Fox News Channel - follow Chris Wallace on Sundays at 10 AM ET as he and his panel discuss hot political topics and issues taking place on Capitol Hill.", url: "http://feeds.foxnews.com/foxnews/fox-news-sunday", site: "http://www.foxnews.com/on-air/fox-news-sunday-chris-wallace/email", image_src: image_src) 
    Section.find_by_id(2).feeds.create!(name: "Fox News Insider: Gretawire", description: "The official blog of Greta Van Susteren. Breaking News, Pictures, Videos, Polls and Live Chat.", url: "http://feeds.foxnews.com/foxnews/blogs/gretawire", site: "http://gretawire.foxnewsinsider.com/", image_src: image_src) 

  #World News
    Section.find_by_id(3).feeds.create!(name: "Fox News: World", description: "Fox News: Fair and Balanced", url: "http://feeds.foxnews.com/foxnews/world", site: "http://www.foxnews.com/world/index.html", image_src: image_src) 

  #Politics
    Section.find_by_id(4).feeds.create!(name: "Fox News: Politics", description: "Fox News: Fair and Balanced", url: "http://feeds.foxnews.com/foxnews/politics", site: "http://www.foxnews.com/politics/index.html", image_src: image_src) 

  #Local
  #Business
  #Opinion
    Section.find_by_id(7).feeds.create!(name: "Fox News: Opinion", description: "Fox News: Fair and Balanced", url: "http://feeds.foxnews.com/foxnews/opinion", site: "http://www.foxnews.com/opinion/index.html", image_src: image_src) 

  #Science
    Section.find_by_id(8).feeds.create!(name: "Fox News: Science", description: "Fox News: Fair and Balanced", url: "http://feeds.foxnews.com/foxnews/science", site: "http://www.foxnews.com/science/index.html", image_src: image_src) 

  #Technology
    Section.find_by_id(9).feeds.create!(name: "Fox News: Tech", description: "Fox News: Fair and Balanced", url: "http://feeds.foxnews.com/foxnews/tech", site: "http://www.foxnews.com/tech/index.html", image_src: image_src) 

  #Health
    Section.find_by_id(10).feeds.create!(name: "Fox News: Health", description: "Fox News: Fair and Balanced", url: "http://feeds.foxnews.com/foxnews/health", site: "http://www.foxnews.com/health/index.html", image_src: image_src) 

  #Sports
    Section.find_by_id(11).feeds.create!(name: "Fox News: Sports", description: "Fox News: Fair and Balanced", url: "http://feeds.foxnews.com/foxnews/sports", site: "http://www.foxnews.com/sports/index.html", image_src: image_src) 

  #Arts and Culture
  #Entertainment
    Section.find_by_id(12).feeds.create!(name: "Fox News: Entertainment", description: "Fox News: Fair and Balanced", url: "http://feeds.foxnews.com/foxnews/entertainment", site: "http://www.foxnews.com/entertainment/index.html", image_src: image_src) 
    Section.find_by_id(13).feeds.create!(name: "Fox News: Fox and Friends", description: "Fox News: Fair and Balanced", url: "http://feeds.foxnews.com/foxnews/foxandfriends", site: "http://www.foxnews.com/on-air/fox-friends/index.html", image_src: image_src) 

  #Lifestyle
    Section.find_by_id(14).feeds.create!(name: "Fox News: Lifestyle", description: "Fox News: Fair and Balanced", url: "http://feeds.foxnews.com/foxnews/lifestyle", site: "http://www.foxnews.com/leisure/index.html", image_src: image_src) 

  #Travel
    Section.find_by_id(15).feeds.create!(name: "Fox News: Travel", description: "Fox News: Fair and Balanced", url: "http://feeds.foxnews.com/foxnews/internal/travel/mixed", site: "http://www.foxnews.com/travel/index.html", image_src: image_src) 

  #Cooking
    Section.find_by_id(16).feeds.create!(name: "Food52", description: "Food community, recipe search, kitchen & home products, and cookbook contests.", url: "http://food52.tumblr.com/rss", site: "http://food52.tumblr.com", image_src: "food52.png") 

  #Photography
  #Humor
  #Books
  #Crosswords and Puzzles
  #Inspirational

  #sections = Section.all(limit: 6)
  #3.times do
    #name = Faker::Lorem.sentence(3)
    #description = Faker::Lorem.sentence(20)
    #url = "http://food52.tumblr.com/rss"
    #site = "http://food52.tumblr.com"
    #image_src = "140x140.png"
    #sections.each { |section| section.feeds.create!(name: name, description: description, url: url, site: site, image_src: image_src) }
  #end #50 times
end

def make_relationships
  admin_user  = User.first
  all_feeds = Feed.all
  followed_feeds = all_feeds[2..20]
  followed_feeds.each { |followed| admin_user.follow!(followed) }
end