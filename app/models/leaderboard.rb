class Leaderboard < ActiveRecord::Base
  has_many :entities, :through => :entries
  has_many :entries, :dependent => :destroy

  def add_entry(entry_params)
    params = entry_params.symbolize_keys 
    entry = self.entries.find_entry_by_entity(params[:name]).first
    if !entry
      entity = Entity.where(name: params[:name]).first || Entity.create(name: params[:name])
      entry = entity.entries.create(leaderboard: self, score: params[:score])
    else
      entry.score = params[:score].to_i
    end
    entry.save
    entry
  end
  
end