class User{
  final int userID;
  final String phoneNumber;
  final String password;

  const User({
    required this.userID,
    required this.phoneNumber,
    required this.password,
  });
  factory User.fromJson(Map<String,dynamic> json) => User(
    userID: json['userID'],
    phoneNumber: json['phoneNumber'],
    password: json['password'],
  );
  Map<String,dynamic> toJson()=>{
    "userID":userID,
    "phoneNumber":phoneNumber,
    "password":password
  };
}