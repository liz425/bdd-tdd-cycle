require 'spec_helper'

describe MoviesController do
  describe "POST 'similar_movies'" do
    before(:each) do
      @fake_results = [mock('movie1'), mock('movie2')]
      @movie = Movie.create!(:title => "Title", :rating => "Rating", :director => "Director", :release_date => Time.now)
    end

    it 'should call the model method that finds similar movies' do
      Movie.should_receive(:find_same_director_movies).with(@movie)
      post :similar_movies, :id => @movie.id
    end

    describe "with a valid director" do
      before(:each) do
        Movie.stub(:find_same_director_movies).and_return(@fake_results)
        post :similar_movies, :id => @movie.id
      end

      it "should render the correct template" do
        response.should render_template('similar_movies')
      end

      it "should make results available to the template" do
        assigns(:same_director_movies).should == @fake_results
      end
    end
  end

  describe "Controller Test" do
    before :each do
      @movie_new = FactoryGirl.build(:movie)
      @movie = FactoryGirl.create(:movie)
    end
    it "index" do
      get :index
      assigns(:movies).count.should eq(1)
    end
    it "do not have title" do
      @movie_without_title = FactoryGirl.create(:movie,:director => '')
      post :similar_movies,:id => @movie_without_title.id
      assigns(:same_director_movies).should == []
    end

    it "create" do
      post :create,:movie => @movie_new
    end

    it "show" do
      get :show,:id => @movie.id
      assigns(:movie).should == @movie
    end

    it "edit" do
      get :edit, {:id => @movie.to_param}
      assigns(:movie).should eq(@movie)
    end

    it "update" do
      put :update, {:id => @movie.to_param}
      response.should        redirect_to(movie_path(@movie))
    end

    it "delete" do
      movie = FactoryGirl.create(:movie)
      expect {
        delete :destroy, {:id => movie.to_param}
      }.to change(Movie, :count).by(-1)
    end

  end

end
