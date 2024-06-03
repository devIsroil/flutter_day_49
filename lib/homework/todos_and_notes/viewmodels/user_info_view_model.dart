

import '../models/user_info.dart';

class UserInfoViewModel {
  UserInfo _userInfo = UserInfo(
    userName: 'Jack',
    userSurname: 'Brown',
    phoneNumber: '+77 123 45 67',
    profilePictureUrl:
        'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
  );

  UserInfo get userInfo {
    return _userInfo;
  }

  void editUserInfo({
    required String newName,
    required String newSurname,
    required String newNumber,
    required String newPicture,
  }) {
    _userInfo.userName = newName;
    _userInfo.userSurname = newSurname;
    _userInfo.phoneNumber = newNumber;
    _userInfo.profilePictureUrl = newPicture;
  }
}
