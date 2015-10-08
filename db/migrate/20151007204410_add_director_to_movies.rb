class AddDirectorToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :director, :string
    add_index :movies, :director
  end
end
