class UsersLoyalty < ApplicationLoyalty
  def update?
    user.id == record.id
  end
end
