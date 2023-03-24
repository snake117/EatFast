class User < ApplicationRecord
  extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_person_name

  friendly_id :username, use: :slugged

  acts_as_favoritor
  acts_as_favoritable

  acts_as_voter

  searchkick word_start: [:username, :first_name, :last_name], word_middle: [:username, :first_name, :last_name]

  validates :first_name, presence: true, length: { in: 2..50 }
  validates :last_name, presence: true, length: { in: 2..50 }
  validates :username, presence: true, uniqueness: true, length: { in: 3..20 }
  validates :gender, presence: true, numericality: { only_integer: true } #, inclusion: { in: %w(Male Female) }
  validates :birthday, presence: true
  validates :country_code, presence: true
  validates :time_zone, presence: true
end
