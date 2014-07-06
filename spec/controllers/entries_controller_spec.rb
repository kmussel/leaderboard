require 'rails_helper'

describe EntriesController do
  
  describe "#create" do
  
    context "when the params are valid" do
      
      before(:each)  do
        
        @leaderboard = Leaderboard.create({name:"Primary"})
        @entity = Entity.create(name: "Entry One")
      end
  
      it "creates  " do
        
        params = {name: 'Entity Two', score: 10}
        post :create, format: :json, leaderboard_id: @leaderboard.id,  entry: params
        expect(response.status).to eq(200)
        expect(json["name"]).to eq(params[:name])
        expect(json["score"]).to eq(params[:score])        
        expect(json["rank"]).to eq(1)                
      end
      
      it "update the score  " do
        
        params = {name: 'Entity One', score: 15}
        post :create, format: :json, leaderboard_id: @leaderboard.id,  entry: params
        expect(response.status).to eq(200)
        
        @entity = Entity.where(name: params[:name]).first

        expect(json["id"]).to eq(@entity.entries.first.id)
        expect(json["rank"]).to eq(1)               
        expect(@entity.entries.first.score).to eq(params[:score])
         
      end
      
      it "creates  " do
        
        params = {name: 'Entity One', score: 10}
        post :create, format: :json, leaderboard_id: @leaderboard.id,  entry: params
        expect(response.status).to eq(200)
        expect(json["name"]).to eq(params[:name])
        expect(json["score"]).to eq(params[:score])        
        expect(json["rank"]).to eq(1)                
      end
      
    end
  end
  
  describe "#show" do
  
    context "when the params are valid" do
      
      before(:each)  do
        
        @leaderboard = Leaderboard.create({name:"Primary"})
        @entity = Entity.create(name:"Entity One")
        @entry = Entry.create(leaderboard_id: @leaderboard.id, entity_id: @entity.id, score: 8)
        @entry.save
      end
  
      it "renders the entity" do
        
        get :show, format: :json, leaderboard_id: @leaderboard.id,  id: @entry.id
        expect(response.status).to eq(200)
        expect(json["name"]).to eq(@entity.name)
        expect(json["score"]).to eq(@entry.score)        
        expect(json["rank"]).to eq(@entry.rank)                
      end
      
      it "renders the 404" do
        
        get :show, format: :json, leaderboard_id: @leaderboard.id,  id: 0
        expect(response.status).to eq(404)
      end
      
    end
  end  

  describe "#index" do
  
      before(:each)  do
        
        @leaderboard = Leaderboard.create({name:"Primary"})
        @entity = Entity.create({name:"test 1", entries_attributes: [{score: 5, leaderboard_id: @leaderboard.id}]})
        @entry = @entity.entries.first
  
      end
  
      it "calls the action with the right parameters" do
        get :index, format: :json, leaderboard_id: @leaderboard.id
        expect(json.count).to eq(1)
        expect(json[0]["id"]).to eq(@entry.id)
      end
      
      it "render html template" do
        get :index, leaderboard_id: @leaderboard.id
        expect(response).to render_template(:index)        
      end
      
  
      
      context "when paging" do
        before(:each) do
          entry2 = Entity.create({name:"test 2", entries_attributes: [{score: 8, leaderboard_id: @leaderboard.id}]})
          entry3 = Entity.create({name:"test 3", entries_attributes: [{score: 2, leaderboard_id: @leaderboard.id}]})          
        end
        
        it "calls the action with the right parameters" do
          get :index, format: :json, leaderboard_id: @leaderboard.id, page: 1, per_page: 2
          expect(json.count).to eq(2)
        end
        
        it "per_page is > 100 raises Bad Request" do
            get :index, leaderboard_id: @leaderboard.id, page: 1, per_page: 200
            expect(response.status).to eq(400)
        end
        
        it "page is out of range raises RangeError" do
            get :index, leaderboard_id: @leaderboard.id, page: -1, per_page: 10
            expect(response.status).to eq(404)
        end
        
      end
  
  
  end
  
  describe "#destroy" do
    before(:each)  do      
      @leaderboard = Leaderboard.create({name:"Primary"})
      @entity = Entity.create({name:"Entity One", entries_attributes: [{score: 8, leaderboard_id: @leaderboard.id}]})
      @entry = @entity.entries.first
    end

    it "renders a 404 when no entity" do
      delete :destroy, format: :json, leaderboard_id: @leaderboard.id, id: 0
      expect(response.status).to eq(404)
    end
  
    it "returns success" do
      delete :destroy, format: :json, leaderboard_id: @leaderboard.id, id: @entry.id
      expect(response.status).to eq(200)
    end
  
  end
  
end
