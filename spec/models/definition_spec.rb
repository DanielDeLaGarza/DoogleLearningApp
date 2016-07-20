#spec/models/definition_spec.rb
require 'spec_helper'
require 'rails_helper'

describe Definition do
  it "has a valid factory" do
    FactoryGirl.create(:word_with_definitions).should be_valid
  end
  it "has a valid word_id" do
    word = FactoryGirl.create(:word_with_definitions, definitions_count: 5)
    word.should be_valid
    word.definitions.count.should eq(5)
    word.definitions.each do |d|
      d.should be_valid
      d.word_id.should eq(word.id)
      d.word_id = nil
      d.should_not be_valid
    end
  end

  it "cannot have blank definition" do
    FactoryGirl.build(:definition, content: '').should_not be_valid
  end

  it "cannot have nil definition" do
    FactoryGirl.build(:definition, content: nil).should_not be_valid
  end
end