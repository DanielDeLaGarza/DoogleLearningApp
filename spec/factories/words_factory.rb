#spec/factories/words_factory.rb
require 'faker'

FactoryGirl.define do
  factory :word do
    sequence :content do |c| "#{"t"*c}est" end

    factory :word_with_definitions do
      transient do
        definitions_count 5
      end

      after(:create) do |word, evaluator|
        create_list(:definition, evaluator.definitions_count, word: word)
      end
    end
  end
end