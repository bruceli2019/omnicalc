class WordCountController < ApplicationController
  def word_count
    @text = params.fetch("user_text")
    @special_word = params.fetch("user_word")

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    #turn string into array so we can count it
    array_words = @text.split
    @word_count = array_words.count

    @character_count_with_spaces = @text.length

    #remove spaces
    text_nosp = @text.gsub(/\s+/,"")
    @character_count_without_spaces = text_nosp.length
    
    # need to clean the string of everything except whitespace and alphanumerics (i.e. remove punctuation), and make everything lowercase
    clean_text = @text.gsub(/[^a-z0-9\s]/i, "").downcase
    
    # turn string into array
    clean_array = clean_text.split
    
    # iterate over array and count number of special words
    num_spec_word = 0
    clean_array.each do |new_word|
      #need to get rid of the \n on special_word
      if @special_word == new_word
        num_spec_word = num_spec_word + 1
      end
    end

    @occurrences = num_spec_word


    render("word_count_templates/word_count.html.erb")
  end

  def word_count_form
    render("word_count_templates/word_count_form.html.erb")
  end
end
