# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :string
#  key         :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Role < ActiveRecord::Base
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :key, presence: true, uniqueness: {case_sensitive: false}, format: {with: /(^[a-zA-Z0-9_-]+$)/}
  validates :description, presence: true

  has_many :users, dependent: :restrict_with_error
end
