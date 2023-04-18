class Api::V1::ContactsController < ApplicationController
  def index
    contact = Contact.all 
    console.log(contact)
    render json: contact, status:200
  end

  def show
    contact = Contact.find_by(id: params[:id])
    if contact
      addresses = contact.addresses 
      # render json: { contact: contact, addresses: addresses }, status: 200 
      # contact_data = contact.as_json.except("address").merge("addresses" => addresses.as_json)
      contact_data = contact.as_json(except: [:address, :created_at, :updated_at]).merge("addresses" => addresses.as_json(except: [:created_at, :updated_at]))
      render json: { contact: contact_data }, status: 200 
    else
      render json: { error: "contact by this id is not present..." }
    end
  end

  def create
    contact=Contact.new(
      create_contacts
    )  
    contact.contact_id = generate_contact_id
    if contact.save
      render json: contact, status:200
    else
      render json:{
          error: " Error in creating contacts"
      }
    end
  end

  def update
    contact = Contact.find_by(id: params[:id])
    if contact 
      contact.update(update_contacts)
      render json: contact, status:200 , message: "Contact updated successfully"
    else
      render json:{
      error: "contact not present..."
      }
    end
  end

  def destroy
    contact = Contact.find_by(id: params[:id])
    if contact 
      contact.destroy
      render json: contact, status:200 , message: "Contact deleted successfully"
    else
    render json:{
     error: "contact not present..
     ."
    }
  end
  end


  def index
    contact=Contact.where(is_active: params[:is_active])
    if contact
      render json: contact, status:200
    else
      render json:{
        error: "contacts are not present by this status"
      }
  end
end

  # def index
  #   if params[:is_active]
  #     contact = Contact.where(is_active: params[:is_active])
  #   else
  #     contact = Contact.all
  #   end
  #   render json: contact
  # end

  private
  def create_contacts
    params.require(:contact).permit([:name, :age, :is_active, :phone_number, :address])
  end
  def update_contacts
    params.require(:contact).permit([:name, :age, :is_active, :phone_number, :address])
  end
  def generate_contact_id
    timestamp = Time.now.to_i.to_s
    random_number = rand(1000..9999).to_s
    timestamp + random_number
  end

end

