require 'spec_helper'
require 'rails_helper'
require 'capybara/rspec'
require 'capybara/rails'

feature 'visitor searches a word', :js => true do

  context 'user inputs a valid real word' do

    scenario 'word already in database', :search => true do
      @word = FactoryGirl.create(:word_with_definitions, definitions_count: 5)
      load_home
      search_word(@word.content)
      expect(page).to have_css('.definition', :minimum => 1)
    end

    scenario 'user inputs valid and real word not in database'do
      load_home
      search_word('test')
      expect(page).to have_css('.definition', :minimum => 1)
    end
  end

  scenario 'user inputs valid word not found in dictionary' do
    load_home
    search_word('plumbus')
    expect(page).to have_text('The word plumbus was not found in our dictionary. are you sure you spelled it right?')
  end

  scenario 'user inputs invalid word with number' do
    load_home
    search_word('word9')
    expect(page).to have_text('Words may not include digits! Please only use letters and hyphens.')
  end

  scenario 'user inputs invalid word with white space' do
    load_home
    search_word('word word')
    expect(page).to have_text('Words may not include spaces! Please only use letters and hyphens.')
  end

  scenario 'user inputs invalid word with both number and white space' do
    load_home
    search_word('word word9')
    expect(page).to have_text('Words may not include digits! Words may not include spaces! Please only use letters and hyphens.')
  end

  scenario 'user inputs invalid word with other special characters' do
    load_home
    search_word('word@')
    expect(page).to have_text('Please only use letters and hyphens.')
  end

  scenario 'user leaves input blank' do
    load_home
    search_word('')
    expect(page).to have_text('Please type a word to search.')
  end

  def load_home
    visit '/'
    #save_and_open_page
  end

  def search_word(word)
    find('#search_field').set(word)
    find('#search_button').click()
  end
end