#spec/models/definition_spec.rb
require 'spec_helper'
require 'rails_helper'

describe Definition do
  it "has a valid factory" do
    FactoryGirl.create(:word_with_definitions).should be_valid
    FactoryGirl.create(:definition).should be_valid
  end
  it "has content" do
    should validate_presence_of(:content)
  end

  it "has word_id" do
    should validate_presence_of(:word_id)
  end

  it "cannot have blank definition" do
    should_not allow_value('').for(:content)
  end

  it "cannot have nil definition" do
    should_not allow_value(nil).for(:content)
  end

  it "cannot have nil word_id" do
    should_not allow_value(nil).for(:word_id)
  end

  it "belongs to word" do
    should belong_to(:word)
  end

  describe "creating word and definitions" do
    let!(:word) {FactoryGirl.create(:word_with_definitions, definitions_count: 5)}

    it "word should be valid" do
      word.should be_valid
    end

    it "definitions count matches amount made" do
      word.definitions.count.should eq(5)
    end

    it "each definition is valid" do
      word.definitions.each do |d|
        d.should be_valid
      end
    end

    it "each definiton's word_id matches word.id" do
      word.definitions.each do |d|
        d.word_id.should eq(word.id)
      end
    end
    it "changing word_id to nil makes every definition invalid" do
      word.definitions.each do |d|
        d.word_id = nil
        d.should_not be_valid
      end
    end
  end
end