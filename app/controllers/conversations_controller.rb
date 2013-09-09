class ConversationsController < ApplicationController

  before_filter :authenticate_user!

  def new

  end

  def index
    @conversations = current_user.conversations
  end

  def show

  end

  def create

  end

  def edit

  end

  def destroy

  end
end
