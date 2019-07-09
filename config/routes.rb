Rails.application.routes.draw do
  resources :courses, only: [], constraints: { format: 'json' }, defaults: { format: 'json' } do
    collection do
      get 'jbuilder'
      get 'cache_crispies'
      get 'fast_jsonapi'
    end
  end
end
