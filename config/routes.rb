AtlassianJobs::Application.routes.draw do
  root :to => 'home#index'

  get '/sites/:name' => 'sites#show'

  get '/tests' => 'tests#index'
end
