class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  add_breadcrumb 'Notes', :notes_path

  respond_to :html, :json, :js

  def index
    @notes = policy_scope(Note).paginate(page: params[:page], per_page: 10).order('id DESC')
  end

  def show
    add_breadcrumb "#{@note.title}", note_path
  end

  def new
    add_breadcrumb 'New', new_note_path
    @note = Note.new
  end

  def edit
    add_breadcrumb 'Edit', edit_note_path
  end

  def create
    @note = Note.new(note_params)
    @note.set_note_user(current_user)
    flash[:notice] = 'Note was successfully created.' if @note.save
    respond_with(@note)
  end

  def update
    flash[:notice] = 'Note was successfully updated.' if @note.update(note_params)
    respond_with(@note)
  end

  def destroy
    redirect_to notes_url, notice: 'Note was successfully destroyed.' if @note.destroy
  end

  private
  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content, :notebook_id, :user_id, :task_id)
  end
end