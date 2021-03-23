class Task < ApplicationRecord

  #Associations
  belongs_to :user

  #Validations
  validates_presence_of :title, :user_id

end
