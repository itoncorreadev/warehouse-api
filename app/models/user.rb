class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  before_create :generate_authentication_token!

  #Associations
  has_many :tasks, dependent: :destroy
  has_many :requests

  #Validations
  validates_uniqueness_of :auth_token

 def info
  "#{email} - #{created_at} - Token: #{Devise.friendly_token}"
 end

 def generate_authentication_token!
   begin
     self.auth_token = Devise.friendly_token
   end while User.exists?(auth_token: auth_token)
 end

end
