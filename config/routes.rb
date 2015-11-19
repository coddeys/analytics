Rails.application.routes.draw do

  get 'questions', to: 'questions#index'
  root 'welcome#index'

end
