Rails.application.routes.draw do
  namespace "api" do
    post  "leads"            => "leads#create"
    patch "leads/:id"        => "leads#update"
    get   "leads/:id/status" => "leads#status"
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
