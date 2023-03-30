# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  birthday               :date             not null
#  business_owner         :boolean          default(FALSE), not null
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  country_code           :string           default(""), not null
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  first_name             :string
#  gender                 :integer          not null
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  slug                   :string           default(""), not null
#  time_zone              :string
#  unconfirmed_email      :string
#  unlock_token           :string
#  username               :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_country_code          (country_code)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_encrypted_password    (encrypted_password) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  extend FriendlyId
  extend Pagy::Searchkick

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :restaurants
  has_many :reviews
  has_many :comments

  has_one_attached :avatar

  has_person_name

  friendly_id :username, use: :slugged

  acts_as_favoritor
  acts_as_favoritable

  acts_as_voter

  searchkick word_start: [:username, :first_name, :last_name], word_middle: [:username, :first_name, :last_name]

  validates :first_name, presence: true, length: { in: 2..50 }
  validates :last_name, presence: true, length: { in: 2..50 }
  validates :username, presence: true, uniqueness: true, length: { in: 3..25 }
  validates :gender, presence: true, numericality: { only_integer: true } #, inclusion: { in: %w(Male Female) }
  validates :birthday, presence: true
  validates :country_code, presence: true
  validates :time_zone, presence: true
  # validates :admin, presence: true
  # validates :business_owner, presence: true

  def search_data
    {
      username: username,
      first_name: first_name,
      last_name: last_name
    }
  end
end
