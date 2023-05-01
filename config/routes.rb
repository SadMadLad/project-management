Rails.application.routes.draw do
  get 'tasks/new'
  get 'tasks/create'
  get 'tasks/edit'
  get 'tasks/update'
  get 'tasks/destroy'
  devise_for :users

  authenticated :user do
    root 'projects#index'
    resources :projects
    resources :tasks
  end

  devise_scope :user do
    unauthenticated :user do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
