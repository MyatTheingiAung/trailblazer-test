class PostsLoyalty < ApplicationLoyalty
  def update?
    user.id == record.user_id
  end
end
