namespace :update_user do
  desc 'update role to admin'

  task update: :environment do
    User.where(role: 'user').each do |t|
      t.update_attribute :role, 'admin'
    end
    puts 'user update successfully!'
  end
end
