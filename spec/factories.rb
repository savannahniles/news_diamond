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
  end

  factory :feed do
    name  "The New York Times"
    description "Lorem ipsum"
    section
  end
end