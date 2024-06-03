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
            height: 200,
            width: 200,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Image.network(
              _userInfoViewModel.userInfo.profilePictureUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text("Your name: ${_userInfoViewModel.userInfo.userName}"),
          Text('Your surname: ${_userInfoViewModel.userInfo.userSurname}'),
          Text('Your phone number: ${_userInfoViewModel.userInfo.phoneNumber}'),
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
                                child: Text('Save'),
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
            child: FilledButton(onPressed: () {}, child: Text("Edit")),
          )
        ],
      ),
    );
  }
}
