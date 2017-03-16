Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :channels, format: 'json' do
    get '/' , action: 'index'
  end
  root 'channels#index'
end
