class RoomsController < ApplicationController
    before_action :authorize_admin
    before_action :set_room, only: [:show, :edit, :update, :destroy]
  
    def index
      @rooms = Room.all
    end
  
    def show
    end
  
    def new
      @room = Room.new
      @room_types = RoomType.all
    end
  
    def create
      @room = Room.new(room_params)
      if @room.save
        redirect_to rooms_path, notice: 'Room was successfully created.'
      else
        render :new
      end
    end
  
    def edit
      @room_types = RoomType.all
    end
  
    def update
      if @room.update(room_params)
        redirect_to rooms_path, notice: 'Room was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @room.destroy
      redirect_to rooms_url, notice: 'Room was successfully destroyed.'
    end
  
    
    private

    def set_room
        @room = Room.find(params[:id])
    end
    
    def room_params
        params.require(:room).permit(:room_number, :room_type_id, :status)
    end
    
end
    
