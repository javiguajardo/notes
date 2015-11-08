class NotebookPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.notebooks.each { |notebook| notebook.id })
      end
    end
  end
end