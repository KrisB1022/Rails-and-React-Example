class Api::V1::OwnersController < ApplicationController
    before_action :set_owner, only: [:show, :update, :destroy]

    # GET /api/v1/owners
    def index
      @owners = Owner.all
  
      render json: @owners
    end
  
    # GET /api/v1/owners/1
    def show
      render json: @owner
    end
  
    # POST /api/v1/owners
    def create
      @owner = Owner.new(owner_params)

      if @owner.save
        render json: @owner, status: :created
      else
        render json: @owner.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/owners/1
    def update
      if @owner.update(owner_params)
        render json: @owner
      else
        render json: @owner.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/owners/1
    def destroy
      @owner.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_owner
        @owner = Owner.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def owner_params
        params.fetch(:owner, {}).permit!
      end
end
