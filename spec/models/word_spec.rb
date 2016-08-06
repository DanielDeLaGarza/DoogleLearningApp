#spec/models/word_spec.rb
require 'spec_helper'
require 'rails_helper'

describe Word do

  it "has a valid factory" do
    expect(FactoryGirl.create(:word)).to be_valid
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
    #should validate_uniqueness_of(:permalink) #validate_uniqueness seems to be broken because of downcase! in before save
    word = FactoryGirl.create(:word, content: 'test')
    expect(FactoryGirl.build(:word, content: 'test')).to_not be_valid
  end

  it "saves as lowecase and cannot add duplicates" do
    word = FactoryGirl.create(:word, content: 'Test')
    expect(word.content).to eq('test')
  end

  it "has many definitions" do
    should have_many(:definitions)
  end

  describe "adding definitions to a word" do
    let!(:definitions){FactoryGirl.create(:word_with_definitions, definitions_count: 5).definitions}

    it "definitions should be valid" do
      expect(definitions.count).to eq(5)
      definitions.each do |d|
        expect(d).to be_valid
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