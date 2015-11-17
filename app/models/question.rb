class Question
  require "redis"
  @redis = Redis.new

  @questions = [
    "How do I cancel my subscription",
    "What is my account number",
    "How do I signup" ]

  def self.suggestions_for(query)
    @redis.zrevrange "analytics", 0, 10
  end

  def self.index_questions
    @questions.each do |q|
      @redis.zincrby "analytics", 0, q
    end
  end

end
