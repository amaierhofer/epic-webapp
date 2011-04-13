class MobileappsController < ApplicationController

  def ringit
    render :layout => 'ringit' if request.get?
  end
  
end
