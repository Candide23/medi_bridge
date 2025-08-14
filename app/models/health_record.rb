class HealthRecord < ApplicationRecord
    belongs_to :user
    has_many :translations, dependent: :destroy

  enum record_type: { prescription: 0, vaccination: 1, doctor_note: 2, other: 3 }

  validates :record_type, :language, presence: true
  
end
