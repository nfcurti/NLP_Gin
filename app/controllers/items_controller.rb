class ItemsController < ApplicationController
  before_action :logged_in_user

  def home
    if logged_in?
        if Stripe::Customer.list({limit: 3, email:current_user.email}).data.length>0
        cus_id =  Stripe::Customer.list({limit: 3, email:current_user.email}).data[0].id
        else
        end
        if Stripe::Subscription.list({limit: 3, customer:cus_id}).data.length>0
          current_user.subid = Stripe::Subscription.list({limit: 3, customer:cus_id}).data[0].id
        else
        end
      p current_user
    else
      p 'NO ESTA LOGUEADO'
    end
  end

  def new
    @item  = current_user.items.new
  end

  def index
    @items = Item.all
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = "Item has been created!"
      redirect_to @item
    else
      render 'new'
    end
  end

  def edit
    @item = current_user.items.find(params[:id])
  end

  def update
    @item = current_user.items.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = "Item updated"
      redirect_to @item
    else
      render 'edit'
    end
  end

  def destroy
    @item = current_user.items.find(params[:id])
    if @item 
      @item.destroy
      flash[:success] = "Item has been deleted"
    else
      flash[:alert] = "Error"
    end
    redirect_to root_path
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name)
  end

end
