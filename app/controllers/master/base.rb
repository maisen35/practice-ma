class Master::Base < ApplicationController
  before_action :authenticate_master_admin!
end
