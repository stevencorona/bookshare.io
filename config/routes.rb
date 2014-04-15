Bookshare::Application.routes.draw do

  root 'pages#index'

  resources :books, param: :isbn do
    member do
      post   'claim'
      delete 'claim' => 'books#unclaim'
    end

    collection do
      get 'search'
      get 'category/:id' => 'books#category'
      get 'categories'
    end
  end

  resources :orders do
    collection do
      post 'shipping'
      get  'payment'
    end
  end

  namespace :admin do
    resources :sessions
    resources :orders do
      member do
        get 'prepare'
        get 'buy'
      end
    end
  end

  get '/faq' => 'pages#faq'
  get '/how' => 'pages#how'

end
