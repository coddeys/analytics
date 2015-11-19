class Question
  require 'redis'
  @redis = Redis.new

  def self.suggestions_for(question, id, shot)
    question = question.strip.downcase
    
    dbvalue = @redis.get "sessions:#{id}:#{shot}"
    diff = sentences_difference(question, dbvalue)
      
    if diff < 80
      shot += 1
      @redis.zincrby 'analytics', 1, question
    else
      @redis.zincrby 'analytics', 1, question
      @redis.zincrby 'analytics', -1, dbvalue
    end
    @redis.set "sessions:#{id}:#{shot}", question
    shot
  end

  def self.all
    questions = @redis.zrevrange 'analytics', 0, -1, withscores: true
    questions.select {|q,s| s > 0 && q.size > 3}
  end

  def self.sentences_difference(question, dbvalue)
    dbvalue ||= ''
    min = [question.size, dbvalue.size].min
    if min > 0
      same = question.each_char.zip(dbvalue.each_char).select { |a,b| a == b }.size
      same * 100 / min 
    else
      0
    end
  end

end
