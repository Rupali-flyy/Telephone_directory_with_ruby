class Api::V1::AddressesController < ApplicationController
  def create
    contact = Contact.find_by(id: params[:id])
    if contact
    address=contact.addresses.new(create_addresses)
    if address.save
      render json: address, status:200
    else
      render json: {
      error: ' address is not created', status:200
    } 
    end
  else
    render json: {
      error: 'contact_id is not present', status:200
    } 
  end
  end

  def index
    adresses = Address.where(contact_id: params[:contact_id])
    if adresses
      render json: adresses, status:200
    else
      render json:{
        error: "contacts are not present by this status"
      }
  end
  end

  private
  def create_addresses
    params.require(:address).permit([:street, :city, :state, :pincode, :contact_id])
  end

end
