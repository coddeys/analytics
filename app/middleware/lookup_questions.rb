class LookupQuestions
  def initialize(app)
    @app = app
  end

  def call(env)
    if env["PATH_INFO"] == "/questions"
      request = Rack::Request.new(env)
      questions = Question.suggestions_for(request.params["q"])
      [200, {"Content-Type" => "application/json"}, [questions.to_json]]
    else
      @app.call(env)
    end
  end
end
