class NotesController < ApplicationController
  before_filter :authenticate_user!
  def index
    if params[:tag]
      @notes = Note.tagged_with(params[:tag])
    else
      @notes = Note.all
    end

    @note = Note.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @notes}
      format.json { render :json => @notes}
    end
  end
  def create
    @note = Note.new(params[:note])
    respond_to do |format|
      if @note.save
        format.html { redirect_to :back, :notice => 'Note was successfully created.' }
        format.xml  { render :xml => @note, :status => :created, :location => @user }
      else
        @notes = Note.all
        format.html { render :action => 'index' }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end
  def destroy
    Note.destroy params[:id]
    redirect_to :back, notice: 'Note moved to trash.'
  end
end
