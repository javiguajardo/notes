class NotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.notes.each { |note| note.id })
      end
    end
  end
end
