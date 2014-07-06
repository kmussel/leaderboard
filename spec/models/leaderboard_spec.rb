require "rails_helper"

describe Leaderboard do

  describe "#add_entry" do
    subject{described_class.new(name:"test")}    
    
    let(:entry_params) { {name: "entity 1", score: 10} }  

    context 'when entry does not exist' do
      it "has name" do
        entry = subject.add_entry(entry_params)
        expect(entry.entity.name).to eq(entry_params[:name])
      end
      it "has score" do      
        entry = subject.add_entry(entry_params)
        expect(entry.score).to eq(entry_params[:score])
      end
    end
  end

end
