require 'spec_helper'

describe UsersController do

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  describe "GET 'new'" do
    it "assigns user" do
      get :new
      assigns(:user)
      response.should be_success
    end
  end


  describe "POST create" do

    it "flashes if username unavailable" do
      User.stub(:new) { mock_user(:available? => false) }
      post :create, :user => {name: 'foo', password: 'foo'}
      response.should render_template "new"
    end

    pending "assigns user" do
      User.stub(:new) { mock_user(:available? => true, :register => false) }
      post :create, :user => {name: 'foo', password: 'foo'}
      response.should render_template "new"
    end
  end

end
