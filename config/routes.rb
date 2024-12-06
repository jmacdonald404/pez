Rails.application.routes.draw do
  post 'chat/respond', to: 'chat#respond'
end
