# frozen_string_literal: true

module Users
    # class UsersPagesController
    class ConversationsController < UsersLayoutController
      def create
        @room = Room.find(params[:room_id])
        @conversation = current_user.conversations.new(room_id: @room.id, content: params[:conversation][:content])
        if @conversation.save
          Turbo::StreamsChannel.broadcast_append_to("chatbox", partial: "users/rooms/partials/conversation", locals: { conversation: @conversation }, target: "list-conversation")
          respond_to do |format|
            format.turbo_stream
          end
        else
          respond_to do |format|
            format.turbo_stream {flash.now[:alert] = "Error! Something went wrong"}
          end
        end
      end
  
      def destroy
        @room = Room.find(params[:room_id])
        @conversation = @room.conversations.find(params[:id])
        if current_user == @conversation.conversationable
          if @conversation.destroy
            Turbo::StreamsChannel.broadcast_remove_to("chatbox", target: "list-conversation-#{@conversation.id}")
            respond_to do |format|
              format.turbo_stream {flash.now[:notice] = "Successfully removed"}
            end
          end
        else
          respond_to do |format|
            format.turbo_stream {flash.now[:alert] = "Error! Something went wrong"}
          end
        end
      end

    end
  end
  