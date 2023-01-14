module SecurityOperation

  def check_user_roles(roles)
    if roles.kind_of?(Array)
      #["user"] => roles
      @user_roles = UserRole.where(user: current_user)
      @user_roles.each do |user_role|
        if user_role.include? user_role.role.name
          return
        end
      end
    else
      raise Exception.new "You must give an array paramater"
    end
    render json: {message: "you have no auth"}, status: 401
  end

end