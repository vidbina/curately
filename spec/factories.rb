require 'ffaker'

FactoryGirl.define do
  factory :user do
    email    { Faker::Internet.email }
    password { SecureRandom.hex }
  end

  factory :client do
    name      { Faker::Company.name }
    shortname { "#{name.split(/,+|&+| +|'+|\-+/).join.downcase[0..14]}" }
  end

  factory :curator do
    name      { Faker::Company.name }
    shortname { "#{name.split(/,+|&+| +|'+|\-+/).join.downcase[0..14]}" }
    template  { create(:template, curator: self) }
  end

  factory :membership do
    user      { create(:user) }
    client    { create(:client) }
    is_admin  { [true, false].sample }
  end

  factory :curatorship do
    user      { create(:user) }
    curator   { create(:curator) }
    is_admin  { [true, false].sample }
  end

  factory :template do
    name      { Faker::HipsterIpsum.word }
    curator   { create(:curator, template: self) }
  end

  factory :element do
    name      { Faker::HipsterIpsum.word }
    template  { create(:template) }
  end

  factory :board do
    curator   { create(:curator) }
    client    { create(:client) }
  end

  factory :update do
    board     { create(:board) }
    time      { DateTime.now }
  end
end
