namespace :analytics do
  desc "Indexing"
  task :questions => :environment do
    Question.index_questions
  end
end
