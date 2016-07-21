class DoogleController < ApplicationController
  def home
  end

  def search
    #try to find word in database
    #if word is found

      #if word has definitions display them
      #else if word has no definitions

        #look for definitions in api
          #if definitions found update and display them
          #else (maybe delete word?) and display word not found error

    #if word not found create new word object
    #if valid?

      #look for definitions in api
        #if definitions found add new word and definitions and display them
        #else display word not found error

    #if not valid?
      #display invalid input error

    #testing stuff
    @word = Word.new
    @word.content = params[:word_entry][:word]
    byebug
    redirect_to root_path
  end
end
