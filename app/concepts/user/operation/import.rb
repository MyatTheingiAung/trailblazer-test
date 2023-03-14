module User::Operation
  class Import < Trailblazer::Operation
    step :import

    def import(options, params, **)
      if options[:params][:file]
        input = options[:params][:file]
        if input.content_type == 'text/csv'
          file = File.open(input)
          CSV.foreach(file.path, headers: true) do |row|
            user_hash = {}
            user_hash[:name] = row['Name']
            user_hash[:email] = row['Email']
            user_hash[:phone] = row['Phone']
            user_hash[:address] = row['Address']
            user_hash[:birthday] = row['Birthday']
            user_hash[:role] = row['Role']
            user_hash[:password] = '123456'
            user_hash[:password_confirmation] = '123456'
            User.create! user_hash
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
