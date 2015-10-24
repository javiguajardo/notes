class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  add_breadcrumb 'Notes', :notes_path

  respond_to :html, :json, :js

  def index
    @notes = Note.paginate(page: params[:page], per_page: 10).order('id DESC')
  end

  def show
  end

  def new
    @note = Note.new
  end

  def edit
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      flash[:notice] = 'Note was successfully created.'
    end

    respond_with(@note)
  end

  def update
    if @note.update(note_params)
      flash[:notice] = 'Note was successfully updated.'
    end

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
    params.require(:note).permit(:title, :content)
  end
end
 
