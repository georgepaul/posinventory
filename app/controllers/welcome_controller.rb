class WelcomeController < ApplicationController

layout "admin"
skip_before_action :verify_authenticity_token

def index

respond_to do |format|
      format.html 
      format.js
      format.json
end

end



end
