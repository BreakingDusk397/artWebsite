class PagesController < ApplicationController

  def home
  end

  def portfolio
  end

  def bio
  end

  def contact
    @contact = Contact.new(pages_params)
  end

    def create
      @contact = Contact.new(pages_params)
      @contact.request = request
      respond_to do |format|
        if @contact.deliver
          # re-initialize Home object for cleared form
          @contact = Contact.new
          format.html { render 'index'}
          format.js   { flash.now[:success] = @message = "Thank you for your message. I'll get back to you soon!" }
        else
          format.html { render 'index' }
          format.js   { flash.now[:error] = @message = "Message did not send." }
        end
      end
    end

    private

    def pages_params
      params.require(:contact).permit(:name, :email, :phone_number, :message)
    end
end
