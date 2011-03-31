require 'spec_helper'

describe JasmineController do

  describe "GET 'disco'" do
    it "should be successful" do
      get 'disco'
      response.should be_success
    end
  end

end
