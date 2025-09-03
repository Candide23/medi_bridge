class Translation < ApplicationRecord
  belongs_to :health_record

  validates :language, :content, presence: true
  validates :language, uniqueness: { scope: :health_record_id }
  validates :language, inclusion: { in: HealthRecord::SUPPORTED_LANGUAGES.map(&:last) }

  # Helper method to get language name
  def language_name
    HealthRecord::SUPPORTED_LANGUAGES.find { |_, code| code == language }&.first || language
  end

  # Scope for finding translations by language
  scope :for_language, ->(lang_code) { where(language: lang_code) }
end

# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :health_records, dependent: :destroy
  has_many :translations, through: :health_records

  # Add preferred language for default translation target
  # You'll need to add this column: rails generate migration AddPreferredLanguageToUsers preferred_language:string
  # validates :preferred_language, inclusion: { in: HealthRecord::SUPPORTED_LANGUAGES.map(&:last) }, allow_blank: true

  def preferred_language_name
    return "English" unless preferred_language.present?
    HealthRecord::SUPPORTED_LANGUAGES.find { |_, code| code == preferred_language }&.first || preferred_language
  end
end