class Api::V1::DogsController < ApplicationController
    before_action :set_dog, only: [:show, :update, :destroy]

    # GET /api/v1/dogs
    def index
      @dogs = Dog.all
  
      render json: @dogs
    end
  
    # GET /api/v1/dogs/1
    def show
      render json: @dog
    end
  
    # POST /api/v1/dogs
    def create
      @dog = Dog.new(dog_params)

      if @dog.save
        render json: @dog, status: :created
      else
        render json: @dog.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/dogs/1
    def update
      if @dog.update(dog_params)
        render json: @dog
      else
        render json: @dog.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/dogs/1
    def destroy
      @dog.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_dog
        @dog = Dog.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def dog_params
        params.fetch(:dog, {}).permit!
      end
end
