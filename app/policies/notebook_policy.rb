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

  def index?
    user.admin? or user.visitor?
  end

  def show?
    user.admin? or user.visitor?
  end

  def new?
    user.admin? or user.visitor?
  end

  def edit?
    user.admin? or user.visitor?
  end

  def create?
    user.admin? or user.visitor?
  end

  def update?
    user.admin? or user.visitor?
  end

  def destroy?
    user.admin? or user.visitor?
  end
end