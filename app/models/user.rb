class User < ActiveRecord::Base

  has_many :events
  has_many :created_events, class_name: "Event"

  has_many :event_attendances
  has_many :attended_events, through: :event_attendances, :source => :event

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: /.*@.*\..*/, message: "must follow '* @ *.*' format" }
  validates :password, presence: true

  include BCrypt

   def password
    @password = Password.new(self.password_digest)
  end

  def password=(secret)
    @password = Password.create(secret)
    self.password_digest = @password
  end


end
