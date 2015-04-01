class RequestsController < ApplicationController
  before_action :find_request, only: [:show, :edit, :update, :destroy, :done]


  def index
   if params[:search]
      s = '%'+params[:search]+'%'
      @requests = Request.where("name LIKE ? OR email LIKE ? OR department LIKE ? OR message LIKE ?", s, s, s, s)
    else
      @requests = Request.all.order("done")
    end
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    @request.done = false

    if @request.save
      flash[:notice] = "Request created successfully!"
      redirect_to request_path(@request)
    else
      render :new
    end

  end

  def show
  end

  def edit
  end

  def update
    if @request.update(request_params)
      redirect_to :requests, notice: "Request updated successfully!"
    else
      render :edit
    end

  end

  def destroy
    @request.destroy
    redirect_to requests_path, notice: "Request deleted successfully!"

  end

private
  def find_request
    @request = Request.find(params[:id])
  end

  def request_params
   params.require(:request).permit(:name, :email, :department, :message, :done)
  end

end
