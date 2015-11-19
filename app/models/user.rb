# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string
#  role_id                :integer
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  deleted_at             :datetime
#

class User < ActiveRecord::Base
  attr_accessor :current_password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  before_create :set_default_role

  validates :username, presence: true, uniqueness: {scope: :role, case_sensitive: false},
            length: {minimum: 4, maximum: 14}, format: {with: /(^[a-zA-Z0-9_-]+$)/}

  belongs_to :role
  has_many :notebooks, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :tasks, dependent: :destroy

  def admin?
    role and role.key == 'admin'
  end

  def visitor?
    role and role.key == 'visitor'
  end

  # instead of deleting, indicate the user requested a delete & timestamp it
  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end

  private
  def set_default_role
    self.role ||= Role.find_by_key('visitor')
  end
end
