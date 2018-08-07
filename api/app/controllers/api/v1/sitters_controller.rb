class Api::V1::SittersController < ApplicationController
    before_action :set_sitter, only: [:show, :update, :destroy]

    # GET /api/v1/sitters
    def index
      @sitters = nil

      if sitter_params[:filterBy] === 'ratingsScore' && sitter_params[:filterByValue]
        @sitters = Sitter.where({ ratings_score: (sitter_params[:filterByValue].to_i)..5 })
      else
        @sitters = Sitter.all
      end

      @sitters = @sitters.order(overall_score: :desc)
      @sitters = @sitters.page(sitter_params[:page] ? sitter_params[:page] : 1)
  
      render json: @sitters, meta: meta_data(@sitters)
    end
  
    # GET /api/v1/sitters/1
    def show
      render json: @sitter
    end
  
    # POST /api/v1/sitters
    def create
      @sitter = Sitter.new(sitter_params)

      if @sitter.save
        render json: @sitter, status: :created
      else
        render json: @sitter.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/sitters/1
    def update
      if @sitter.update(sitter_params)
        render json: @sitter
      else
        render json: @sitter.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/sitters/1
    def destroy
      @sitter.destroy
    end
  
    private
      def set_sitter
        @sitter = Sitter.find(params[:id])
      end
  
      def sitter_params
        params.permit(:page, :sortOrder, :sortBy, :filterBy, :filterByValue)
      end

      def meta_data(obj)
        meta = {
          previous_page: obj.previous_page,
          current_page: obj.current_page,
          next_page: obj.next_page,
          total_count: obj.total_entries,
          total_pages: obj.total_pages
        }
      end
end
