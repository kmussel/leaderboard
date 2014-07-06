require "rails_helper"

describe Entry do
  
  before(:each)  do
    
    @leaderboard = Leaderboard.create({name:"Primary"})
    @entity = Entity.create({name:"Entity One", entries_attributes: [{score: 8, leaderboard_id: @leaderboard.id}]})
    @entry = @entity.entries.first
    Entity.create({name:"Entity two", entries_attributes: [{score: 12, leaderboard_id: @leaderboard.id}]})
    Entity.create({name:"Entity three", entries_attributes: [{score: 5, leaderboard_id: @leaderboard.id}]})

  end
  
  describe ".find_entry_by_entity" do

    it "returns the right entry" do
      @leaderboard.reload
      entry = @leaderboard.entries.find_entry_by_entity(@entity.name).first
      expect(entry).to_not be_nil
      expect(entry.score).to eq(8)
    end
  end
  
  describe "#rank" do

    it "returns the right entry" do
      expect(@entry.rank).to eq(2)
    end
  end

end
