Rails.application.routes.draw do
#  resources :employees, only: [:index, :show, :create, :update, :destroy]
#   Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/employees/index', to: 'employees#index'
  get '/employees/create', to: 'employees#create'
  get '/employees/show', to: 'employees#show'
  put '/employees/update', to: 'employees#update'
  get '/employees/tax_deduction', to: 'employees#tax_deduction'
  get '/employees/calculate_total_salary', to: 'employees#calculate_total_salary'
  get '/employees/calculate_tax_and_cess', to: 'employees#calculate_tax_and_cess'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
