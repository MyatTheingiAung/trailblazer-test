namespace :post do
  desc 'delete posts'

  task delete: :environment do
    Post.destroy_all
  end
end
