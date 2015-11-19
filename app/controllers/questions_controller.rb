class QuestionsController < ApplicationController

  def index
    session[:shot] = 1 unless session[:shot]
    shot = Question.suggestions_for(params[:q], session.id, session[:shot])
    session[:shot] = shot
    head :ok
  end
end
