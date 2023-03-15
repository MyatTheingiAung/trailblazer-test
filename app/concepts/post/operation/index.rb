module Post::Operation
  class Index < Trailblazer::Operation
    step :get_post_list

    def get_post_list(options, **)
      current_user = options['current_user']
      if current_user
        options['posts'] = current_user.role == 'admin' ? Post.order('id DESC').all : Post.where(user_id: current_user.id).or(Post.where(privacy: 'public')).order('id DESC').all
      else
        options['posts'] = Post.where(privacy: 'public').order('id DESC').all
      end
    end
  end
end
