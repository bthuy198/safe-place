# frozen_string_literal: true

module Users
    # class UsersPagesController
    class ConversationsController < UsersLayoutController
      def create
        @room = Room.find(params[:room_id])
        @conversation = current_user.conversations.new(room_id: @room.id, content: params[:conversation][:content])
        if @conversation.save
          Turbo::StreamsChannel.broadcast_prepend_to("chatbox", partial: "users/rooms/partials/conversation", locals: { conversation: @conversation }, target: "list-conversation")
        else
        end
      end
  
      def destroy
        @room = Room.find(params[:room_id])
        @conversation = @room.conversations.find(params[:id])
        if current_user == @conversation.conversationable
          if @conversation.destroy
            Turbo::StreamsChannel.broadcast_remove_to("chatbox", target: "list-conversation-#{@conversation.id}")
          end
        else
          
        end
      end

    end
  end
  