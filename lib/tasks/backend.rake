desc "launch the service"

namespace :epic do
  pid_file = "log/epic.pid"

  desc "Starts the epic backend service"
  task :start => :environment  do
    if not File.exists? pid_file
      $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), %w[.. .. lib]))
      require 'epic'
    else 
      puts "#{pid_file} exists, epic should be running"
    end
  end

  desc "Stops the epic backend service"
  task :stop  do
    if File.exists? pid_file
      sh "kill `cat #{pid_file}`"
    else
      puts "#{pid_file} does not exists, epic should not be running"
    end
  end

  desc "list users"
  task :list do
    sh "ejabberdctl registered_users psi"
  end
   
  desc "clear users"
  task :clear => :environment do
    User.delete_all
    str= <<EOF
for i in `ejabberdctl  registered_users psi | egrep 'epic\\w+'`; do 
  echo "unregistering $i"
  ejabberdctl unregister $i psi
done
EOF
    sh str
  end
end
