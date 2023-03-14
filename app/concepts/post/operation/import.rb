module Post::Operation
  class Import < Trailblazer::Operation
    step :import

    def import(options, params, **)
      if options[:params][:file]
        input = options[:params][:file]
        if input.content_type == 'text/csv'
          file = File.open(input)
          CSV.foreach(file.path, headers: true) do |row|
            post_hash = {}
            post_hash[:title] = row['Title']
            post_hash[:description] = row['Description']
            post_hash[:privacy] = row['Privacy']
            name = row['Username'].strip
            user = User.where(name: name).first
            post_hash[:user_id] = user.id
            Post.create! post_hash
          end
        else
          options[:file] = 'File type must be: text/csv'
          false
        end
      else
        options[:file] = 'File field is required'
        false
      end
    end
  end
end
