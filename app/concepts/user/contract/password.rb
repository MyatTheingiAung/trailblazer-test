module User::Contract
  class Password < Reform::Form
    property :password
    property :password_confirmation

    validates :password, presence: true, confirmation: true
    validates :password_confirmation, presence: true
  end
end
