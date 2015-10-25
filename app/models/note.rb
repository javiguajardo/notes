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
#

class Note < ActiveRecord::Base
  validates :title, presence: true, uniqueness: {scope: :notebook, case_sensitive: false}
  validates :content, presence: true
  validates :notebook_id, presence: true

  belongs_to :notebook
  delegate :name, to: :notebook, prefix: true
end
