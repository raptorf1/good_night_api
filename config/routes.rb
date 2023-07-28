Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :users, only: %i[index show create update destroy]
      resources :sleep_wake_times, only: %i[index show create update destroy]
    end
  end
end
