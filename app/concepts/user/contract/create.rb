module User::Contract
  class Create < Reform::Form
    property :name
    property :email
    property :password
    property :password_confirmation
    property :phone
    property :address
    property :birthday
    property :role

    validates :name, presence: true, length: { maximum: 30 }
    validates :email, presence: true, length: { maximum: 30 },
                            format: { with:  Constants::VALID_EMAIL_REGEX }
    validates :password, presence: true, confirmation: true
    validates :password_confirmation, presence: true
    validates :phone, allow_blank: true, length: { minimum: 8, maximum: 13 }
    validates :address, length: { maximum: 255 }, allow_blank: true
    validates :birthday, length: { maximum: 255 }, allow_blank: true
    validates :role, presence: true
  end
end
