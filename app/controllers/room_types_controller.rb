class RoomTypesController < ApplicationController
    before_action :authorize_admin
    before_action :set_room_type, only: [:show, :edit, :update, :destroy]
  
    def index
      @room_types = RoomType.all
    end
  
    def show
    end
  
    def new
      @room_type = RoomType.new
    end
  
    def create
      # debugger
      @room_type = RoomType.new(room_type_params)
      if @room_type.save
        redirect_to room_types_path, notice: 'Room type was successfully created.'
      else
        render :new
      end
    end
  

    def edit
    end
  
    def update
      if @room_type.update(room_type_params)
        redirect_to room_types_path, notice: 'Room type was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @room_type.destroy
      redirect_to room_types_path, notice: 'Room type was successfully destroyed.'
    end
  
    private
  
    def set_room_type
      @room_type = RoomType.find(params[:id])
    end
  
    def room_type_params
      params.require(:room_type).permit(:name, :rate)
    end
end
  
