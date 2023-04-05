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
  # include MeiliSearch::Rails

  extend FriendlyId
  # extend Pagy::Meilisearch
  extend Pagy::Searchkick

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :addresses, as: :addressable
  has_many :addressable, through: :addresses #, as: :addressable, inverse_of: :user, source: :addressable, source_type: "Address", class_name: "Address", dependent: :destroy # , inverse_of: :user
  # has_many :addresses, through: :addresses, as: :addressable, dependent: :destroy, class_name: "Address"
  has_many :restaurants, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :addresses, reject_if: :all_blank, allow_destroy: true

  has_one_attached :avatar

  has_person_name

  friendly_id :username, use: :slugged

  acts_as_favoritor
  acts_as_favoritable

  acts_as_voter

  pay_customer stripe_attributes: :stripe_attributes, default_payment_processor: :stripe

  # meilisearch do
  #   attribute :email
  #   attribute :username
  #   attribute :first_name
  #   attribute :last_name

  #   sortable_attributes [:gender, :birthday, :created_at, :updated_at]
  #   filterable_attributes [:gender, :country_code, :time_zone]
  # end

  validates :first_name, presence: true, length: { in: 2..50 }
  validates :last_name, presence: true, length: { in: 2..50 }
  validates :username, presence: true, uniqueness: true, length: { in: 3..25 }
  validates :gender, presence: true, numericality: { only_integer: true } #, inclusion: { in: %w(Male Female) }
  validates :birthday, presence: true
  validates :country_code, presence: true
  validates :time_zone, presence: true
  # validates :admin, presence: true
  # validates :business_owner, presence: true

  searchkick word_start: [:username, :first_name, :last_name], word_middle: [:username, :first_name, :last_name]

  def search_data
    {
      username: username,
      first_name: first_name,
      last_name: last_name
    }
  end

  def stripe_attributes(pay_customer)
    {
      address: {
        line1: pay_customer.owner.line_one,
        line2: pay_customer.owner.line_two,
        city: pay_customer.owner.city,
        state: pay_customer.owner.state,
        country: pay_customer.owner.country
      },
      metadata: {
        pay_customer_id: pay_customer.id,
        user_id: id # or pay_customer.owner_id
      }
    }
  end
end
