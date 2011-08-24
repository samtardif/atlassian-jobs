AtlassianJobs::Application.routes.draw do
  root :to => 'home#index'

  get '/github' => 'sites#show', :service => 'github'

  get '/tests' => 'tests#index'
end
