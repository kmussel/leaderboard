class LeaderboardsController < ApplicationController
  respond_to :json

  def index
    @leaderboards = Leaderboard.all
  end

  def show
  end

  def create
  end

  def update
  end


end