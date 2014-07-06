class EntitiesController < ApplicationController
  respond_to :html, :json
  before_filter :load_leaderboard

  def new

  end
  
  def index

  end

  def show
    @entity = Entity.find(params[:id])
    respond_with @entity
  end

  def create
  end

  def update
  end
  
  def destroy
    @entity = Entity.find(params[:id])    
    @entity.destroy

    respond_to do |format|
      format.html {
        redirect_to({ action: 'index'})
      }
      format.json {
        head :ok
      }
    end
  end
  
end 