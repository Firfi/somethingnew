module Api
  module V1
    class NotesController < ApplicationController

      include NotesHelper

      respond_to :json

      def index
        @notes = current_notes
        respond_with(current_notes) do |format|
          format.json {
            render :json => to_json(@notes)
          }
        end
      end

      def show
        respond_with current_notes.find(params[:id])
      end

      def create
        respond_with current_notes.create(params[:note])
      end

      def update
        respond_with current_notes.update(params[:id], params[:note])
      end

      def destroy
        respond_with current_notes.destroy(params[:id])
      end

    end
  end
end
