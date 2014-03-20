namespace :books do
  desc "This task reloads all data for books"

  task :reload => :environment do
    Book.all.each do |book|
      BookLoader.refresh(book)
    end
  end

end
