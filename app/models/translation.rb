class Translation < ApplicationRecord
   belongs_to :health_record

  validates :language, :content, presence: true
    
end
