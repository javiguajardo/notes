# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Course < ActiveRecord::Base
  validates :name, presence: true, uniqueness: {scope: :user, case_sensitive: false}
  validates :user_id, presence: true

  belongs_to :user
  has_many :tasks, dependent: :restrict_with_error
  has_many :notebooks, dependent: :restrict_with_error

  def set_course_user(user)
    self.user_id = user.id
  end
end
