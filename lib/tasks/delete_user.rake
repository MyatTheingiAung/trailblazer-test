namespace :delete_user do
  desc 'delete users'

  task delete: :environment do
    User.destroy_all
    puts 'user delete successfully!'
  end
end
