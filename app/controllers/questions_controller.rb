class QuestionsController < ApplicationController

  def index
    render json: Question.suggestions_for(params[:q])
  end
end
