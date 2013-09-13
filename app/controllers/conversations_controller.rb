class ConversationsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @conversation = Conversation.find_or_create_by_user_ids(current_user.id, params[:recipient_id])
    redirect_to conversation_path(@conversation)
  end

  def index
    @conversations = current_user.conversations
  end

  def show
    @conversation = Conversation.find(params[:id])
    @other_user = @conversation.other_user(current_user)
  end

  def create

  end

  def edit

  end

  def destroy

  end
end
