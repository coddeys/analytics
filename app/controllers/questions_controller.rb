class QuestionsController < ApplicationController

  def index
    Question.suggestions_for(params[:q], session.id)
    head :ok
  end
end
