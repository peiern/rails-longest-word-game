# frozen_string_literal: true

require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    @arr = %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]
    10.times { @letters << @arr.sample }
  end

  def score
    input = params[:answer].upcase
    letters = params[:letters]

    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    read_file = URI.open(url).read
    words_found = JSON.parse(read_file)

    # The word can’t be built out of the original grid
    # if input is not from letters then
    input_arr = input.chars
    letters_arr = letters.chars
    comparison = input_arr.all? { |alphabet| input_arr.count(alphabet) <= letters_arr.count(alphabet) }
    @result = "Sorry but #{input} can't be build out of #{letters}" unless comparison

    # The word is valid according to the grid, but is not a valid English word
    # if word found = false
    @result = "Sorry but #{input} doesn't seem to be a valid English word..." unless words_found["found"]
    # The word is valid according to the grid and is an English word
    # if word found = true
    # return "Congratulations! #{word} is a valid English word!"
  end
end
