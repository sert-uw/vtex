Rails.application.routes.draw do
  devise_for :users

  root 'projects#index'

  resources 'projects' do
    resource 'pdf_creates', only: [:show]
    resource 'files', only: [:create, :update, :destroy]
    resource 'error_pages', only: [:show]
  end
end
