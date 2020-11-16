require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score

    @grid = params[:letters].split(' ')
    @word_split =params[:word].upcase.split('')

    unless @word_split.all? { |letter| @word_split.count(letter) <= @grid.count(letter) }
    return @message = "Sorry but #{params[:word]} can't be build out of #{params[:letters]}"
    end

    def english_word?(word)
      response = open("https://wagon-dictionary.herokuapp.com/#{word}")
      json = JSON.parse(response.read)
      return json['found']
    end
    return @message = "Sorry but #{params[:word].upcase} does not seem to be an English word" unless english_word?(params[:word])
    @message = "Congratulations, #{params[:word].upcase} is a valid English word!"

    game_score = params[:word].length

    if session[:total_score].nil?
      session[:total_score] = game_score
    else session[:total_score] += game_score
    end
  end

end
