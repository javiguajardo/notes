# == Schema Information
#
# Table name: notebooks
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Notebook < ActiveRecord::Base
  validates :name, presence: true, uniqueness: {scope: :user, case_sensitive: false}
  validates :user_id, presence: true

  has_many :notes, dependent: :restrict_with_error
  belongs_to :user

  def set_notebook_user(user)
    self.user_id = user.id
  end
end
