class DuesController < ApplicationController
  before_action :set_due, only: [:show, :edit, :update, :destroy]

  def copy
    return unless params[:customer_id] and params[:newsletter_id] and params[:section]
    customer = Customer.find(params[:customer_id])
    newsletter_id = params[:newsletter_id]
    customer.copy_prev_newsletter_dues_to_newsletter(newsletter_id)
    redirect_to customer_newsletter_bills_path(customer.id, newsletter_id, section: params[:section]), notice: "Last newsletter's dues copied successfully!"
  end

  # GET /dues
  # GET /dues.json
  def index
  end

  # GET /dues/1
  # GET /dues/1.json
  def show
  end

  # GET /dues/new
  def new
    @bill = Bill.new
    @due = @bill.dues.build
  end

  # GET /dues/1/edit
  def edit
  end

  # POST /dues
  # POST /dues.json
  def create
    @bill = Bill.new
    @due = @bill.dues.build

    respond_to do |format|
      if @due.save
        format.html { redirect_to @due, notice: 'Due was successfully created.' }
        format.json { render action: 'show', status: :created, location: @due }
      else
        format.html { render action: 'new' }
        format.json { render json: @due.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dues/1
  # PATCH/PUT /dues/1.json
  def update
    respond_to do |format|
      if @due.update(due_params)
        format.html { redirect_to @due, notice: 'Due was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @due.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dues/1
  # DELETE /dues/1.json
  def destroy
    @due.destroy
    respond_to do |format|
      format.html { redirect_to dues_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_due
      @due = Due.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def due_params
      params[:due].permit!
    end
end
