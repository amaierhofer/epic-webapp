
require 'spec_helper'

describe JasmineController do
  describe "routing" do
    it "routes /test to jasmine#index" do
      { :get => "/test" }.should route_to(:controller => "jasmine",:action => "index")
    end

    it "routes /test/docs to jasmine#index" do
      { :get => "/test/docs" }.should route_to(:controller => "jasmine",:action => "docs")
    end
  end
end

