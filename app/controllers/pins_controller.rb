class PinsController < ApplicationController
	before_action :find_pin, only: [:show, :edit, :update, :destroy]
	def index
		get_and_show_pins
	end

	def new
		@pin = current_user.pins.build
	end

	def create
		@pin = current_user.pins.build(pin_params)

		if @pin.save
			redirect_to @pin, notice: "Successfully created new Pin"
		else
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
		if @pin.update_attributes(pin_params)
			redirect_to @pin, notice: "Successfully updated pin"
		else
			render 'edit'
		end
	end

	def destroy
		@pin.destroy
		redirect_to @pin
	end

	private

	def pin_params
		params.require(:pin).permit(:title, :description, :image)
	end

	def find_pin
		@pin = Pin.find(params[:id])
	end

	def get_and_show_pins
        @pins = Pin.paginate(page: params[:page], per_page: 3)
    end
end
