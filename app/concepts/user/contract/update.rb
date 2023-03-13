module User::Contract
  class Update < Reform::Form
    property :name
    property :email
    property :phone
    property :address
    property :birthday
    property :role

    validates :name, presence: true, length: { maximum: 30 }
    validates :email, presence: true,
                            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
    validates_uniqueness_of :email
    validates :phone, allow_blank: true, numericality: true, length: { minimum: 8, maximum: 13 }
    validates :address, length: { maximum: 255 }, allow_blank: true
    validates :birthday, length: { maximum: 255 }, allow_blank: true
    validates :role, presence: true
  end
end
