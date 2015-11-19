class Question
  require "redis"
  @redis = Redis.new

  def self.suggestions_for(question, id)
    dbvalue = @redis.get "sessionid:#{id}"
    @redis.set "sessionid:#{id}", question
    if dbvalue
      @redis.zincrby "analytics", -1, dbvalue
      @redis.zincrby "analytics", 1, question
    end
  end

  def self.analytics_update(questions)
  end

  def self.all
    questions = @redis.zrange "analytics", 0, -1, withscores: true
    questions.select {|q,s| s > 0 }
  end

end
