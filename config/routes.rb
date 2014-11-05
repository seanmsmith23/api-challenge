Rails.application.routes.draw do
  get '/query' => 'query#show', as: :query
end
