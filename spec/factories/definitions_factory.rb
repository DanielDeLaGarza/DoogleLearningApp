#spec/factories/definitions_factory.rb
require 'faker'

FactoryGirl.define do
  factory :definition do
    content {Faker::Hacker.say_something_smart}
    word_id 1
    word
  end
end