class Product < ApplicationRecord

  #Associations
  belongs_to :group
  belongs_to :category
  has_many :details, dependent: :destroy

  # Validations
  validates_presence_of :name, :group_id

end
