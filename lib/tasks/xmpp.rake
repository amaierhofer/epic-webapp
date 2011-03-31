
desc "interact with xmpp server"
namespace :xmpp do
  url = "http://admin:admin@psi:5280/admin/server/psi"

  desc "add a user"
  task :add do
    RestClient.post "#{url}/users", :newusername => 'test', :newuserpassword => 'test', :addnewuser => 'Add User'
  end

  desc "delete a user"
  task :del do

    RestClient.post "#{url}/user/test" , {:removeuser => 'Remove User'}
  end
end
