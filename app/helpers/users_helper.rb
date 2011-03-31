module UsersHelper
  def new_message
    link_to 'New Message', new_user_message_path(@user), 'data-role' => 'button', 
      'data-rel' => 'dialog', 'data-transition' => 'pop'
  end
end
