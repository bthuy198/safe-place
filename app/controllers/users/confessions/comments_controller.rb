# frozen_string_literal: true

module Users
  module Confessions
    # class Comments Controller
    class CommentsController < Users::CommentsController
      before_action :set_commentable
      before_action :set_comments, only: %i[index]
      # before_action :set_comment

      private

      def set_commentable
          @commentable = Confession.find_by(id: params[:confession_id])
      end

      def set_comments
        @comments = @commentable.comments.includes(:rich_text_comment,
        :user).order(created_at: :desc).page(params[:page]).per(3)
        @current_page = @comments.current_page
        @total_pages = @comments.total_pages
        @has_next_page = @current_page < @total_pages
      end

      def set_comment
          @comment = @commentable.comments.find_by(params[:id])
          return unless @comment.nil?

          respond_to do |format|
            format.html { redirect_to root_path, alert: 'Comment not found.' }
            format.json { head :no_content }
          end
      end
    end
  end
end
