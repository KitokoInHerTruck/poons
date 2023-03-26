class Admin::ElevagesController < Admin::BaseController
     
def admin
   @elevages = ::Elevage.all
end


  def index
    @elevages = ::Elevage.all
  end

  def show
    @elevage = ::Elevage.find(params[:id])
  end

  def new
    @elevage = ::Elevage.new
  end

  def create
    @elevage = ::Elevage.new(elevage_params)
    if @elevage.save
      redirect_to admin_elevages_path, notice: "Comment created successfully"
    else
      render :new
    end
  end

  def edit
    @celevage = ::Elevage.find(params[:id])
  end

  def update
    @elevage = ::Elevage.find(params[:id])
    if @elevage.update(elevage_params)
      redirect_to admin_elevages_path, notice: "Comment updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @elevage = ::Elevage.find(params[:id])
    @elevage.destroy
    redirect_to admin_elevages_path, notice: "Comment deleted successfully"
  end

  def home
      @elevage = ::Elevage.first
      render 'admin/elevages/show'
  end

  private

  def elevage_params
    params.require(:elevage).permit(:content, :product_id)
  end

end
