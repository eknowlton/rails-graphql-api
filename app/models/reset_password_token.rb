class ResetPasswordToken < ApplicationRecord
  belongs_to :user

  validates :body, uniqueness: true

  has_secure_token :body

  scope :active, -> { where('created_at >= ?', expires).where(used: false) }

  def self.find_active(body)
    active.find_by(body: body)
  end

  def self.expires
    1.day.ago
  end

  def use
    update(used: true)
  end
end
