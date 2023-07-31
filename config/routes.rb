Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :users, only: %i[index show create destroy]
      resources :sleep_wake_times, only: %i[index create update]
      resources :follows, only: %i[create destroy]
    end
  end
end
