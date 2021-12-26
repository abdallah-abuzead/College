enum UserType { user, admin }

String getUserTypeName(UserType userType) {
  switch (userType) {
    case UserType.user:
      return 'User';
    case UserType.admin:
      return 'Admin';
  }
}

UserType getUserTypeByName(String userType) {
  switch (userType) {
    case 'User':
      return UserType.user;
    case 'Admin':
      return UserType.admin;
    default:
      return UserType.user;
  }
}
