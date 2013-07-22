class MachinesController < ApplicationController
  def index
    @machines = Machine.search(params[:search])
    if @machines.length == 0
      @machines == Machine.all
    end
  end

  def show
  end
end
