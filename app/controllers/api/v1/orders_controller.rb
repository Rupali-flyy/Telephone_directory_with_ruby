class Api::V1::OrdersController < ApplicationController
  def create
    product = Product.find_by(product_id: params[:product_id])
    # p product
    contact = Contact.find_by(id: params[:contact_id])
    # p contact
    if contact.nil?
      render json: { error: "Contact not found" }, status: 404
      return
    end
    address = Address.where(contact_id: params[:contact_id])
    # address = contact&.address # Retrieve the associated address if the contact exists
    if product && contact # Ensure both product and contact exist
      order = Order.create(product_id: product.id, contact_id: contact.id)
      p order
      order.order_id = generate_order_id
   
      render json: { 
               order: order.as_json(except: [:id, :created_at, :updated_at]),
               product: product.as_json(except: [:created_at, :updated_at]), 
               contact: contact.as_json(except: [:created_at, :updated_at]), 
               address: address.as_json(except: [:created_at, :updated_at]) }, 
       status: 200

    else
      render json: { error: "Invalid product_id or contact_id" }, status: 400
    end
  end

  private
  def generate_order_id
    timestamp = Time.now.to_i.to_s
    random_number = rand(1000..9999).to_s
    timestamp + random_number
  end
 
end
