class NotesController < ApplicationController
  before_filter :authorize
  before_filter :init, :only => [:index]

  def index
  end

  def create
    if current_user.notes.new(params[:note]).save
      flash[:notice] = "New note created"
    end
    redirect_to :notes
  end

  def edit
    @note = current_user.notes.find(params[:id])
  end

  def update
    @note = current_user.notes.find(params[:id])
    if @note.update_attributes(params[:note])
      redirect_to @note, notice: "Note has been updated."
    else
      render "edit"
    end
  end

  def destroy
    @note = current_user.notes.find(params[:id])
    @note.destroy
    redirect_to :notes
  end

  private

  def init
    @notes = current_user.notes.all
    @note = current_user.notes.new
  end

end
