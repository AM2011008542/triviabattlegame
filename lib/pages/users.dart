class Users {
  String userID;
  final String userName;
  final String userEmail;
  final String userPassword;
  final String userPhone;
  final String userCourse;
  final String userBio;
  final String userLocation;
  final int userPoint;
  final int userToQ;
  final String imageUrl;
  final List<String> index;

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
    required this.imageUrl,
    required this.index,
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
    'imageUrl': imageUrl,
    'index': index,
  };
}