class NotesController < ApplicationController

  include NotesHelper

  respond_to :html

  before_filter :authorize
  before_filter :init, :only => [:index]

  def index
  end

  def create
    @note = current_notes.new(params[:note])
    if @note.save
      flash[:notice] = t('note.created')
      redirect_to :notes
    else
      @notes = current_notes
      render :index
    end

  end

  def edit
    @note = current_notes.find(params[:id])
  end

  def update
    @note = current_notes.find(params[:id])
    if @note.update_attributes(params[:note])
      redirect_to @note, notice: t('note.updated')
    else
      render 'edit'
    end
  end

  def destroy
    @note = current_notes.find(params[:id])
    @note.destroy
    redirect_to :notes
  end

  private

  def init
    @notes = current_notes
    @note = current_notes.new
  end

end
