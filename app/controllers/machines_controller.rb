class MachinesController < ApplicationController
  def index
    category = params[:category] if params[:category] == "3d Printer" || params[:category] == "Laser Cutter"
    @machines = Machine.search(params[:search], {distance: params[:distance], category: category})
    if @machines.length == 0
      @machines == Machine.all
    end
  end

  def search
    category = params[:category] if params[:category] == "3d Printer" || params[:category] == "Laser Cutter"
    @machines = Machine.search(params[:search], {distance: params[:distance], category: category})
    if @machines.length == 0
      @machines == Machine.all
    end
    respond_to do |format|
      format.json { render json: @machines }
    end
  end

  def show
    @machine = Machine.find(params[:id])
  end
end
