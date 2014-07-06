class CreateEntity < ActiveRecord::Migration
  def change
    create_table :entities do |t|      
      t.string :name, :null => false, :unique => true
      t.timestamps      
    end
    
    create_table :entries do |t|
      t.belongs_to :entity
      t.belongs_to :leaderboard      
      t.integer :score
      t.timestamps      
    end
    
    add_index :entities, :name, unique: true
    add_index :entries, [:leaderboard_id, :entity_id], :unique => true
  end
end
