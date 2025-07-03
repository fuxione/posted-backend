Rails.application.routes.draw do
  # Leads API
  post "api/leads" => "leads#create"
  patch "api/leads/:id" => "leads#update"
  get "api/leads/:id/status" => "leads#status"

  get "up" => "rails/health#show", as: :rails_health_check
end
