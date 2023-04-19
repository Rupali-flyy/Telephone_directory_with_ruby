require 'securerandom'

class Api::V1::ProductsController < ApplicationController
  def create
    product=Product.new(
      create_products
    )  
    product.product_id = generate_product_id
    if params[:product][:quantity].present?
      # Multiply the total_amount by quantity if present
      product.total_amount = product.total_amount * params[:product][:quantity].to_i
    end
    if product.save
      render json: product, status:200
    else
      render json:{
          error: " Error in creating contacts"
      }
    end
  end

  private
  def create_products
    params.require(:product).permit([:product_name, :product_type, :quantity, :total_amount])
  end
  def generate_product_id
    timestamp = Time.now.to_i.to_s
    random_number = rand(1000..9999).to_s
    timestamp + random_number
  end
end
