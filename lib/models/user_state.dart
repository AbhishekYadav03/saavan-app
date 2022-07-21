class UserState {
  UserState({
    this.userLoggedIn,
  });

  int? userLoggedIn;

  factory UserState.fromJson(Map<String, dynamic> json) => UserState(
        userLoggedIn: json["user_logged_in"],
      );

  Map<String, dynamic> toJson() => {
        "user_logged_in": userLoggedIn,
      };
}
