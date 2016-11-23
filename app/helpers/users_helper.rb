module UsersHelper
  def avatar(user)
    image_tag (user.avatar.url(:thumb))
  end
end
