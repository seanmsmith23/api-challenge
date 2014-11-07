Rails.application.routes.draw do
  get '/query' => 'queries#show', as: :query
end
