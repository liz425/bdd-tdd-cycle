class Movie < ActiveRecord::Base

  attr_accessible :title, :rating, :director, :description, :release_date

  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.find_similar_movies(movie)
    Movie.where("director = '#{movie.director}' AND title != '#{movie.title}'")
  end

end

