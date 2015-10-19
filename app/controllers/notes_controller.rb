 
 
class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json, :js

  def index
    @notes = Note.all
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
    @note.save
    respond_with(@note)
  end 

  def update
    @note.update(note_params)
    flash[:notice] = 'Note was successfully updated.'
    respond_with(@note)
  end 

  def destroy
    @note.destroy
    redirect_to notes_url, notice: 'Note was successfully destroyed.'
  end 

  private
    def set_note
      @note = Note.find(params[:id])
    end 

    def note_params
      params.require(:note).permit(:title, :content) 
    end 
end
 
