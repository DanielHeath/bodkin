Bodkin::Application.routes.draw do
  resources :reminders
  root 'welcome#index'

  post 'postmark/inbound' => 'postmark#inbound'
  get 'postmark/inbound' => 'postmark#inbound'
end
