#spec/models/word_spec.rb
require 'spec_helper'
require 'rails_helper'

describe Word do

  it "has a valid factory" do
    FactoryGirl.create(:word).should be_valid
  end
  it "has content" do
    should validate_presence_of(:content)
  end
  it "accepts hyphenated words" do
    should allow_value('able-bodied').for(:content)
  end
  it "cannot have nil content" do
    should_not allow_value(nil).for(:content)
  end
  it "cannot have blank content" do
    should_not allow_value('').for(:content)
  end
  it "cannot have whitespace in content" do
    should_not allow_value('hello hello').for(:content)
    should_not allow_value('tab   tab').for(:content)
  end

  it "is unique" do
    #should validate_uniqueness_of(:permalink) #validate_uniqueness seems to be broken, doesn't recognize downcase! in before save
    word = FactoryGirl.create(:word, content: 'test')
    FactoryGirl.build(:word, content: 'test').should_not be_valid
  end

  it "saves as lowecase and cannot add duplicates" do
    word = FactoryGirl.create(:word, content: 'Test')
    word.content.should eq('test')
  end

  it "has many definitions" do
    should have_many(:definitions)
  end

  describe "adding definitions to a word" do
    let!(:definitions){FactoryGirl.create(:word_with_definitions, definitions_count: 5).definitions}

    it "definitions should be valid" do
      definitions.count.should eq(5)
      definitions.each do |d|
        d.should be_valid
      end
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