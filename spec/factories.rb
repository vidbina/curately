FactoryGirl.define do
  factory :user do
    email    { Faker::Internet.email }
    password { SecureRandom.hex }
  end

  factory :client do
    name      { Faker::Company.name }
    shortname { "#{name.split(/,+|&+| +|'+|\-+/).join.downcase[0..14]}" }
  end
end
