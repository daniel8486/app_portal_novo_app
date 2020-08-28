Rails.application.routes.draw do
  namespace :pages do
    get 'point/index'
    post 'point/index'
  end
  namespace :pages do
    get 'points/index'
    post 'points/index'
  end
  namespace :users do
    get 'login/index'
  end
  namespace :pages do
    get 'dice/index'
  end
  namespace :pages do
    get 'dashboard/index'
    delete 'dashboard/destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'users/login#index'

  get '/v1/wsdl/inicio' => 'pages/dashboard#index'
  get '/v1/wsdl/meus-dados' => 'pages/dice#index'
  get '/v1/wsdl/espelho-do-ponto' => 'pages/point#index'
  get '/v1/wsdl/justificativa-de-excessoes' => 'pages/points#index'
  post '/v1/wsdl/justificativa-de-excessoes' => 'pages/points#index'
  delete 'v1/wsdl/sair' => 'pages/dashboard#delete'
  #post '/v1/wsdl/enviar' => 'pages/point#index'


end
