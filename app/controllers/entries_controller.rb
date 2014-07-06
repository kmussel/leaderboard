class EntriesController < ApplicationController
  respond_to :html, :json
  before_filter :load_leaderboard

  def new
    @entry = @leaderboard.entries.build()
  end
  
  def index
    page = params[:page] ? params[:page].to_i : 1
    per_page = params.fetch(:per_page, Entry.per_page).to_i

    raise ActionController::BadRequest.new("BadRequest", Exception.new('Max of 100 entries')) and return if per_page > 100    
    
    params[:per_page] = per_page
    @entries = @leaderboard.entries.paginate(page: page, per_page: per_page)    
    respond_with @entries
  end

  def show
    @entry = Entry.find(params[:id])
    respond_with @entry
  end

  def create
    @entry = @leaderboard.add_entry(entry_params)
    respond_to do |format|
      format.html {
        redirect_to leaderboard_entries_path(@leaderboard)
      }
      format.json {
        render json: EntrySerializer.new(@entry).to_json
      }
    end
  end

  def update
  end
  
  def destroy
    @entry = Entry.find(params[:id])    
    @entry.destroy

    respond_to do |format|
      format.html {
        redirect_to({ action: 'index'})
      }
      format.json {
        head :ok
      }
    end
  end
  

private

  def load_leaderboard
    @leaderboard = Leaderboard.find(params[:leaderboard_id]) if params[:leaderboard_id]
  end
  
  def entry_params
    params.require(:entry).permit(:name, :score)
  end
  
end