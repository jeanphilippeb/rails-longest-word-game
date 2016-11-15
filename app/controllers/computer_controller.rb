require 'open-uri'
require 'json'

class ComputerController < ApplicationController
  def game
    @grid = generate_grid(10)
  end

  def score
    @displayed_grid = params[:grid]
    @attempt = params[:attempt]
    @score = run_game(@attempt, get_translation(@attempt), @displayed_grid)
  end

private

  def generate_grid(grid_size)
    Array.new(grid_size) { ('A'..'Z').to_a[rand(26)] }
  end

  def included?(guess, grid)
    guess.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  # def run_game(attempt, grid)
  #   result[:translation] = get_translation(attempt)
  #   result[:score], result[:message] = score_and_message(
  #     attempt, result[:translation], grid)
  #   result
  # end

  def run_game(attempt, translation, grid)
    if included?(attempt.upcase, grid)
      if translation
        score = compute_score(attempt)
        [score, "well done"]
      else
        [0, "not an english word"]
      end
    else
      [0, "not in the grid"]
    end
  end

  def get_translation(word)
    api_key = "363e83de-77b3-46d6-bd24-cee19de72a3es"
    begin
      response = open("https://api-platform.systran.net/translation/text/translate?source=en&target=fr&key=#{api_key}&input=#{word}")
      json = JSON.parse(response.read.to_s)
      if json['outputs'] && json['outputs'][0] && json['outputs'][0]['output'] && json['outputs'][0]['output'] != word
        return json['outputs'][0]['output']
      end
    rescue
      if File.read('/usr/share/dict/words').upcase.split("\n").include? word.upcase
        return word
      else
        return nil
      end
    end
  end



end
