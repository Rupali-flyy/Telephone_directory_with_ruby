class Api::V1::ContactsController < ApplicationController
  def index
    contact = Contact.all 
    render json: contact, status:200
  end

  def show
   contact = Contact.find_by(id: params[:id])
    if contact
      render json: contact, status:200
    else
    render json:{
     error: "contact by this id is not present..."
    }
  end
  end

  def create
    contact=Contact.new(
      create_contacts
    )  
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

  # def contacts_by_status
  #   is_active = params[:is_active]
  #   if is_active
  #   contacts = contacts.find{} 

  # end

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

end

