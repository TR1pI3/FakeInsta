class AddUniqueIndexToRelationships < ActiveRecord::Migration[7.1]
  def change
    add_index :relationships, [:follower_id, :followee_id], unique: true
  end
end
