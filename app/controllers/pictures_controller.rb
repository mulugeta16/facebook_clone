class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :user_login_check, only: [:new]

  def index
    @pictures = Picture.all
  end

  def show
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def edit
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if params[:back]
      render :new
    else
      if @picture.save
        redirect_to @picture, notice: 'Picture was posted'
      else
        render :new
      end
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end
  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was updated' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html {redirect_to pictures_url, notice: 'Picture was deleted'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def picture_params
      params.require(:picture).permit(:content, :image, :image_cache)
    end

    def user_login_check
   unless logged_in?
     redirect_to root_path
   end
 end
end
