class User < ApplicationRecord
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  validates :name, presence: true
  validates :role, presence: true
  validates :phone, allow_blank: true, length: { minimum: 8, maximum: 13 }
  validates :address, length: { maximum: 255 }, allow_blank: true
  validates :birthday, length: { maximum: 255 }, allow_blank: true

  # :database_authenticatable - hashing the password and validating the authenticity of a user while signing in
  # :registerable - user sign_up
  # :recoverable - resetting the user password and send reset instructions
  # :rememberable - manages generating and clearing token for remembering the user from a saved cookie. Rememberable also has utility methods for dealing with serializing the user into the cookie and back from the cookie, trying to lookup the record based on the saved information. You probably wouldn't use rememberable methods directly, they are used mostly internally for handling the remember token
  # :validatable - creates all needed validations for a user email and password. It's optional, given you may want to create the validations by yourself. Automatically validate if the email is present, unique and its format is valid. Also tests presence of password, confirmation and length
  # :confirmable -
end
