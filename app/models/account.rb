class Account < ApplicationRecord
  belongs_to :group

  validates :name, uniqueness: { scope: :group, message: "is already taken in this group." }, length: { maximum: 100 }
  validates :group, presence: true

end
