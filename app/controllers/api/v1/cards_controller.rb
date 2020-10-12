class Api::V1::CardsController < ActionController::API
  before_action :set_card, only: [:show, :update, :destroy]

  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    cards = Card.select(:id, :japanese_text, :english_text, :source)
    render json: cards
  end

  def show
    render json: @card
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      render status: :created
    else
      render status: 400, json: { status: 400, message: 'Success' }
    end
  end

  def update
    if @card.update(card_params)
      render status: 200, json: { status: 200 }
    end
  end

  def destroy
    if @card.destroy!
      render status: 200, json: { status: 200 }
    end
  end

  private

    def set_card
      @card = Card.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:japanese_text, :english_text, :source)
    end

    def render_status_404(exception)
      render json: { errors: [exception] }, status: 404
    end

    def render_status_500(exception)
      render json: { errors: [exception] }, status: 500
    end
end
