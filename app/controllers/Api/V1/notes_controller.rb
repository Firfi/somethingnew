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
        if @note
          @note.tags.each do |tag|
            tag.name.split('').inject('') {|t, s| t << s; Rails.cache.delete(["tags", @note.user_id, t]); t}
          end
        end
        respond_with @note
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
