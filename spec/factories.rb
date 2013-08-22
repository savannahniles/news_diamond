FactoryGirl.define do
  factory :user do
    sequence(:first_name)  { |n| "First Name #{n}" }
    sequence(:last_name)  { |n| "Last Name #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :section do
    name     "Cooking"
    rank     "12"
    image_src      "../../assets/140x140.png"
  end

  factory :feed do
    #name  "The New York Times"
    #description "Lorem ipsum"
    #section
    sequence(:name)  { |n| "Feed #{n}" }
    sequence(:description)  { |n| "Description goes here." }
    sequence(:url)  { "www.cnn.com/rss" }
    sequence(:site)  { "www.cnn.com" }
    sequence(:image_src)  { "src" }
    section
  end

  factory :article do
    title "Lorem ipsum"
    url "www.cnn.com"
    author "Boo Bear"
    summary "Lorem ipsum"
    content "Lorem ipsum"
    published Time.now
    feed
  end
end

