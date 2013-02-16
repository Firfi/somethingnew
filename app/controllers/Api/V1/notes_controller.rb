module Api
  module V1
    class NotesController < ApplicationController

      include NotesHelper

      respond_to :json


      def index
        respond_with current_notes
      end

      def show
        respond_with current_notes.find(params[:id])
      end

      def create
        @note = current_notes.create(params[:note])
        respond_with @note

      end

      def update
        respond_with current_notes.update(params[:id], params[:note])
      end

      def destroy
        respond_with current_notes.destroy(params[:id])
      end

      private

      def respond_note(notess)
        respond_with notess do |format|
          format.json { render :json => to_json(notess) }
        end
      end
    end
  end
end
