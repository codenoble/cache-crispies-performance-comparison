Rails.application.routes.draw do
  resources :courses, only: [], constraints: { format: 'json' }, defaults: { format: 'json' } do
    collection do
      get 'jbuilder'
    end
  end
end
