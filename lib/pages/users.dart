class Users {
  String userID;
  final String userName;
  final String userEmail;
  final String userPassword;
  final String userPhone;
  final String userCourse;
  final String userBio;
  final String userLocation;
  final String userPoint;
  final String userToQ;

  Users({
    this.userID = '',
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.userPhone,
    required this.userCourse,
    required this.userBio,
    required this.userLocation,
    required this.userPoint,
    required this.userToQ,
  });

  Map<String, dynamic> toJson() => {
    'userID': userID,
    'userName': userName,
    'userEmail': userEmail,
    'userPassword': userPassword,
    'userPhone': userPhone,
    'userCourse': userCourse,
    'userBio': userBio,
    'userLocation': userLocation,
    'userPoint': userPoint,
    'userToQ': userToQ,
  };
}