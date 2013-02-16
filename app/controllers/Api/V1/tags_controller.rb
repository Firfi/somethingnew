module Api
  module V1
    class TagsController < ApplicationController

      respond_to :json

      def autocomplete
        respond_with Tag.tags_for current_user, (params[:query] || '')
      end

    end
  end
end
