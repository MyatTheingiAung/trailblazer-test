namespace :post do
  desc 'update privacy to public'

  task update: :environment do
    Post.where(privacy: 'private').each do |t|
      t.update_attribute :privacy, 'public'
    end
  end
end
