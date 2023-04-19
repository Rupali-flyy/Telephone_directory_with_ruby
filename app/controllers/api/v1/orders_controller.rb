class Api::V1::OrdersController < ApplicationController
  def create
    product = Product.find_by(product_id: params[:product_id])
      # Access quantity and total_amount from the product instance
      quantity = product.quantity
      total_amount = product.total_amount
      if product.nil?
        render json: { error: "Product not found" }, status: 404
        return
      end

   
    # contact = Contact.find_by(id: params[:contact_id])
    # address = Address.where(contact_id: params[:contact_id])
    # address = contact&.address # Retrieve the associated address if the contact exists
    # Use joins to retrieve the associated Address record for the Contact
    # address = Address.joins(:contact).where("contacts.id = ?", params[:contact_id])
    contact = Contact.joins(:addresses).find_by(id: params[:contact_id])
    if contact.nil?
      render json: { error: "Contact not found" }, status: 404
      return
    end


   if product && contact # Ensure both product and contact exist
      order = Order.create(product_id: product.id, contact_id: contact.id)
      p order
      order.order_id = generate_order_id
   
      render json: { 
        order: order.as_json(except: [:id, :created_at, :updated_at]),
        product: product.as_json(except: [:created_at, :updated_at]), 
        contact: contact.as_json(except: [:created_at, :updated_at], include: {
          addresses: { except: [:created_at, :updated_at] }
        })
      },  
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
