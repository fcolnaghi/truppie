class SubscribersController < ApplicationController
  def create
    @subscriber = Subscriber.new(params.require(:subscriber).permit(:email))
    
    if !@subscriber.valid?
      flash[:error] = @subscriber.errors.messages[:email][0]
      if request.referrer
        redirect_to request.referrer + '#warning'
      else
        redirect_to root_path + '#warning'
      end
    else
       if @subscriber.save
          flash[:success] = "Você foi inscrito com sucesso, aguarde as novidades"
          ContactMailer.notify("O usuário do email #{@subscriber.email} se inscreeu na Newsletter por #{request.referrer}").deliver_now
          redirect_to request.referrer + '#warning'
       end 
    end
  end
end
