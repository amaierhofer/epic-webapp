require 'spec_helper'

describe User do

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end
#  pending "test active record callback that should create user"
end
