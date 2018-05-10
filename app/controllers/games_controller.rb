require 'json'
require 'rest-client'

class GamesController < ApplicationController
  def new
    @letters = []
    alphabet = ('a'..'z').to_a;
    10.times do
      @letters << alphabet[rand(0..alphabet.length-1)].upcase
    end

  end

  def score

    @word_from_user = params[:input]
    @letters_generated = params[:token]


    comparer = comparer(@word_from_user, @letters_generated)
    english = english_word?(@word_from_user)

    if comparer && english
      @response = "SUCCESFUL"
    else
      @response = "REPAILA"
    end
  end

private

def comparer(attempt, grid_join)
  attempt.upcase.split("").all? do |letter|
    grid_join.include?(letter)
    grid_join.slice(letter)
  end
end

def english_word?(attempt)
  url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
  word_serialized = RestClient.get(url).body
  word = JSON.parse(word_serialized)
  return word["found"]
end

# def run_game(attempt, grid)
#   url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
#   word_serialized = RestClient.get(url).body
#   word = JSON.parse(word_serialized)

#   grid_join = grid.join("")
#   comparer_response = comparer(attempt, grid_join)
#   # answer_response(attempt, time, word, comparer_response)
# end

# def answer_response(attempt, time, word, comparer_response)
#   if comparer_response
#     if word['found']
#       return { score: 100.0 + attempt.length - time, time: time, message: "Well Done" }
#     else
#       return { message: "not an english word", score: 0, time: time }
#     end
#   else
#     return { time: time, score: 0, message: "Some letters are not in the grid" }
#   end
# end


end
