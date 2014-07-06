class Entry < ActiveRecord::Base
  self.per_page = 10  
  belongs_to :entity
  belongs_to :leaderboard

  default_scope { order('id DESC') }
  
  scope :find_entry_by_entity, -> (name) { joins(:entity).where(entities: {name: name}) }
  
  def rank
    Entry.where("score > ? and leaderboard_id = ?", score, leaderboard.id).count + 1
  end
end