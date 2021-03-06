# == Schema Information
#
# Table name: notes
#
#  id          :integer          not null, primary key
#  title       :string
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  notebook_id :integer
#  user_id     :integer
#  task_id     :integer
#

class Note < ActiveRecord::Base
  validates :title, presence: true, uniqueness: {scope: [:notebook, :user], case_sensitive: false}
  validates :content, presence: true
  validates :notebook_id, presence: true
  validates :user_id, presence: true

  belongs_to :notebook
  belongs_to :user
  belongs_to :task

  delegate :name, to: :notebook, prefix: true
  delegate :username, to: :user, prefix: true
  delegate :name, to: :task, prefix: true

  def set_note_user(user)
    self.user_id = user.id
  end
end
