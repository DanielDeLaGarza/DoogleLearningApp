require 'spec_helper'
require 'rails_helper'

describe DoogleController do
  describe "GET home" do
    it "renders the home page" do
      get :home
      expect(response).to render_template("home")
    end
  end

  describe "GET search" do

    context "word already in database" do

      it "returns definitions" do
        FactoryGirl.create(:word_with_definitions, definitions_count: 5)

        get :search, format: :json, params: { word_entry: {word: 'test'} }

        parsed_response = JSON.parse(response.body)

        expect(parsed_response['definitions'].length).to eq(5)
        expect(parsed_response['validation_text'].length).to eq(0)
      end
    end

    context "real word not in database" do

      it "returns definitions" do
        stub_request(:get, 'http://www.dictionaryapi.com/api/v1/references/collegiate/xml/test').with(:query =>
                    { :key => 'cab72891-f003-43ef-a983-253666d45082'
                    }).to_return(:body => "<dt>:test</dt>")

        get :search, format: :json, params: { word_entry: {word: 'test'} }

        parsed_response = JSON.parse(response.body)

        expect(parsed_response['definitions'].length).to eq(1)
        expect(parsed_response['definitions'][0]).to eq('test')
        expect(parsed_response['validation_text'].length).to eq(0)
      end
    end

    context "valid word non real word" do

      it "returns validation text for word not found" do
        stub_request(:get, 'http://www.dictionaryapi.com/api/v1/references/collegiate/xml/testytest').with(:query =>
                    { :key => 'cab72891-f003-43ef-a983-253666d45082'
                    }).to_return(:body => '')

        get :search, format: :json, params: { word_entry: {word: 'testytest'} }

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['definitions'].length).to eq(0)
        expect(parsed_response['validation_text']).to eq('The word testytest was not found in our dictionary. are you sure you spelled it right?')
      end
    end

    context "invalid word" do
      it "returns validation text for invalid word" do
        get :search, format: :json, params: { word_entry: {word: 'test@'} }

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['definitions'].length).to eq(0)
        expect(parsed_response['validation_text']).to eq(' Please only use letters and hyphens.')
      end
    end
  end
end