AtlassianJobs::Application.routes.draw do
  root :to => 'application#index'

  get '/github' => 'sites#show', :service => 'github'
end
