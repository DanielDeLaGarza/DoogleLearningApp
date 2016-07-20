#spec/models/word_spec.rb
require 'spec_helper'
require 'rails_helper'

describe Word do
  it "has a valid factory" do
    FactoryGirl.create(:word).should be_valid
  end
  it "accepts hyphenated words" do
    FactoryGirl.create(:word, content: 'able-bodied').should be_valid
  end
  it "cannot have nil word" do
    FactoryGirl.build(:word, content: nil).should_not be_valid
  end
  it "cannot have blank word" do
    FactoryGirl.build(:word, content: '').should_not be_valid
  end
  it "cannot have whitespace in word" do
    FactoryGirl.build(:word, content: 'hello hi').should_not be_valid
    FactoryGirl.build(:word, content: 'word  n   tab').should_not be_valid
  end

  it "saves as lowecase and cannot add duplicates" do
    word = FactoryGirl.create(:word, content: 'Test')
    word.content.should eq('test')
    FactoryGirl.build(:word, content: 'test').should_not be_valid
  end

  it "should have acces to definitons with definitons method" do
    word = FactoryGirl.create(:word_with_definitions, definitions_count: 5)
    word.should be_valid
    word.definitions.count.should eq(5)
    word.definitions.each do |d|
      d.should be_valid
    end
  end

  describe "deleting word" do

    let!(:word){FactoryGirl.create(:word_with_definitions, definitions_count: 5)}

    it "decreases word count" do
      expect{word.destroy}.to change{Word.count}.by(-1)
    end

    it "decreases definitions count" do
      expect{word.destroy}.to change{Definition.count}.by(-5)
    end
  end
end