class ReviewsController < ApplicationController
  before_action :set_booking, only: [:new, :create, :edit, :update]
  before_action :set_review, only: [:edit, :update, :show]
  respond_to :js, only: :update

  def new
    @review = @booking.reviews.new
    authorize @review
  end

  def create
    @review = @booking.reviews.new(review_params)
    authorize @review
    if @booking.user == current_user
      @review.review_type = "cto"
    else
      @review.review_type = "otc"
    end
    if @review.save
      redirect_to edit_booking_review_path(@booking, @review)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @review.update(review_params)

    # validations spécifiques
    if @review.review_type == "cto"
      if @review.quality_rating
      else
        flash[:alert] = "Merci de noter entre 1 et 5 le rapport qualité/prix"
        render :edit
      end
    elsif @review.booking.offer.type_of_offer == "rent"
      if @review.respect_rating
      else
        flash[:alert] = "Merci de noter entre 1 et 5 le respect du matériel"
        render :edit
      end
    end

    # validations générales
    if @review.communication_rating
      if @review.punctuality_rating
        if @review.recommendation
          redirect_to offers_path
        else
          flash[:alert] = "Merci de nous donner votre recommandation"
          render :edit
        end
      else
        flash[:alert] = "Merci de noter entre 1 et 5 la ponctualité"
        render :edit
      end
    else
      flash[:alert] = "Merci de noter entre 1 et 5 la communication"
      render :edit
    end
  end

  def show
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def set_review
    @review = Review.find(params[:id])
    authorize @review
  end

  def review_params
    params.require(:review).permit(:comment, :communication_rating, :punctuality_rating, :respect_rating, :quality_price_rating, :recommendation)
  end
end
