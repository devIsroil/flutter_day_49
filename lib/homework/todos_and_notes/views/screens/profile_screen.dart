import 'package:flutter/material.dart';

import '../../viewmodels/user_info_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserInfoViewModel _userInfoViewModel = UserInfoViewModel();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String userName = '';
  String userSurname = '';
  String phoneNumber = '';
  String profilePictureUrl = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 150,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(shape: BoxShape.rectangle),
            child: _userInfoViewModel.userInfo.profilePictureUrl.isNotEmpty
                ? Image.network(
              _userInfoViewModel.userInfo.profilePictureUrl,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                }
              },
              errorBuilder: (BuildContext context, Object error,
                  StackTrace? stackTrace) {
                return const Icon(
                  Icons.broken_image,
                  size: 150,
                );
              },
            )
                : const Icon(
              Icons.person,
              size: 150,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text("Name: ${_userInfoViewModel.userInfo.userName}"),
          Text('Surname: ${_userInfoViewModel.userInfo.userSurname}'),
          Text('Phone number: ${_userInfoViewModel.userInfo.phoneNumber}'),
          TextButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                initialValue:
                                _userInfoViewModel.userInfo.userName,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Enter your name';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  if (newValue != null) {
                                    userName = newValue;
                                  }
                                },
                              ),
                              TextFormField(
                                initialValue:
                                _userInfoViewModel.userInfo.userSurname,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Enter your surname';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  if (newValue != null) {
                                    userSurname = newValue;
                                  }
                                },
                              ),
                              TextFormField(
                                initialValue:
                                _userInfoViewModel.userInfo.phoneNumber,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Enter your phone number';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  if (newValue != null) {
                                    phoneNumber = newValue;
                                  }
                                },
                              ),
                              TextFormField(
                                initialValue: _userInfoViewModel
                                    .userInfo.profilePictureUrl,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Enter your profile image url';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  if (newValue != null) {
                                    profilePictureUrl = newValue;
                                  }
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    _userInfoViewModel.editUserInfo(
                                      newName: userName,
                                      newSurname: userSurname,
                                      newNumber: phoneNumber,
                                      newPicture: profilePictureUrl,
                                    );
                                    setState(() {});
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: const Text(
              "Edit",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
