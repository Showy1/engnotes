class Api::V1::CardsController < ActionController::API
  before_action :set_card, only: [:show, :update, :destroy]

  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    user_cards = Card.where(user_id: current_user.id).order(id: 'DESC')
    $review_timings = [1, 4, 7, 11, 15, 20, 30]
    user_cards.each do |user_card|
      unless user_card.done == true && (Time.zone.today - user_card.done_time).to_i >= $review_timings[user_card.phase]
        next
      end

      user_card.done = false
      user_card.phase += 1 unless user_card.phase == $review_timings.length - 1
      user_card.save
    end
    cards = user_cards.select(:id, :japanese_text, :english_text, :source, :phase, :user_id, :note, :done, :done_time)
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
    render status: 200, json: { status: 200 } if @card.update(card_params)
  end

  def destroy
    render status: 200, json: { status: 200 } if @card.destroy!
  end

  private

    def set_card
      @card = Card.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:japanese_text, :english_text, :source, :phase, :note, :done, :done_time).merge(user_id: current_user.id)
    end

    def render_status_404(exception)
      render json: { errors: [exception] }, status: 404
    end

    def render_status_500(exception)
      render json: { errors: [exception] }, status: 500
    end
end
