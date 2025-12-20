import 'package:flutter/material.dart';

enum UserStatus { blocked, available }

class User extends ChangeNotifier {
  String? _userId;
  String? _firstName;
  String? _lasttName;
  // Date birthday;
  /*
  Image imageId;
  Image image;
  int phoneNumber;
  bool isProvider;
  bool isAdmin;
  bool isCustomer;*/
  // UserStatus status;
  ImageProvider _profileImg = AssetImage("images/user.png");
  List<Notification>? _notifications;

 ImageProvider get profileImage => _profileImg;
 void setProfileImage(ImageProvider image) {
    _profileImg = image;
    notifyListeners(); // ✅ هنا المكان الصحيح
  }
  
}
