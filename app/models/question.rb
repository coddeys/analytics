class Question

  @questions = [
    "How do I cancel my subscription",
    "What is my account number",
    "How do I signup" ]

  def self.suggestions_for(q)
    @questions
  end
end
