require 'spec_helper'

describe Movie do
  describe "with a director" do
    before(:each) do
      @movie1 = Movie.create!(:title => "Title", :rating => "Rating", :director => "Chuck")
      @movie2 = Movie.create!(:title => "Title", :rating => "Rating", :director => "Chuck")
      @movie3 = Movie.create!(:title => "Title", :rating => "Rating", :director => "Chuck")
      @movie4 = Movie.create!(:title => "Title", :rating => "Rating", :director => "Brenda")
    end

    it "should contain all movies" do
      Movie.all.should include @movie1
      Movie.all.should include @movie2
      Movie.all.should include @movie3
      Movie.all.should include @movie4
    end

    describe "if similar movies exist" do
      it "should find all similar movies" do
        result = Movie.find_same_director_movies(@movie3)
        result.should include @movie1
        result.should include @movie2
        result.should_not include @movie3
        result.should_not include @movie4
      end
    end

    describe "if no similar movies exist" do
      it "should not find any similar movies" do
        result = Movie.find_same_director_movies(@movie4)
        result.should be_empty

      end
    end
  end
end