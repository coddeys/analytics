class Question
  require "redis"
  @redis = Redis.new

  @questions = [
    "How do I cancel my subscription",
    "What is my account number",
    "How do I signup" ]

  def self.suggestions_for(query)
    @redis.del "out"
    @redis.zinterstore("out", ["analytics", "suggestions_for:#{query.downcase}"])
    analytics_update(@redis.zrange("out", 0, -1))
    questions = @redis.zrevrange "out", 0, 10, withscores: true
    questions.map { |h| h[0].to_s + " (" + h[1].to_s + " searches)"}
  end

  def self.index_questions
    @questions.each do |q|
      @redis.zincrby "analytics", 0, q
      index_suggestion q, q
      q.split.each { |k| index_suggestion(k, q) }
    end
  end

  def self.index_suggestion(key,value)
    1.upto(key.length) do |n|
      prefix = key[0,n]
      @redis.sadd "suggestions_for:#{prefix.downcase}", value
    end
  end

  def self.analytics_update(questions)
    questions.each do |q|
      @redis.zincrby "analytics", 1, q
    end
  end

end
