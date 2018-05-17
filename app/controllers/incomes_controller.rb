class IncomesController < ApplicationController
  require 'csv'

  def index
    @incomes = Income.all
  end

  def new
    @income = Income.new
  end

  def create
    file = params[:income][:file]
    if parse(file)
      redirect_to incomes_path
    else
      render :new
    end
  end

  def parse(file)
    CSV.foreach(file.path, { headers: true, :col_sep => "\t" }) do |row|
      income = Income.new
      income.user = current_user
      income.purchaser_name = row["purchaser name"]
      income.item_description = row["item description"]
      income.item_price = row["item price"]
      income.purchase_count = row["purchase count"].to_i
      income.merchant_address = row["merchant address"]
      income.merchant_name = row["merchant name"]
      income.save
    end
  end
end

