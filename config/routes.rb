Rails.application.routes.draw do
  resources :courses, only: [], constraints: { format: 'json' }, defaults: { format: 'json' } do
    collection do
      get 'jbuilder'
      get 'cache_crispies'
      get 'cache_crispies_cached'
      get 'fast_jsonapi'
      get 'blueprinter'
      get 'active_model_serializer'
      get 'panko_serializer'
    end
  end
end
