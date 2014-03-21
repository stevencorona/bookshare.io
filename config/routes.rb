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

  get '/faq' => 'pages#faq'

end
