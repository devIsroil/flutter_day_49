import 'package:flutter/material.dart';
import 'package:flutter_lesson_49/homework/todos_and_notes/views/screens/password_screen.dart';
import '../../utils/app_constants.dart';
import '../screens/course_admin_screen.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';

class CustomDrawer extends StatelessWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onBackgroundChanged;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<Color> onColorChanged;
  final Function(Color, double) onTextChanged;

  const CustomDrawer({
    super.key,
    required this.onThemeChanged,
    required this.onBackgroundChanged,
    required this.onLanguageChanged,
    required this.onColorChanged,
    required this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppConstants.appColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Menu",
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: AppConstants.textSize,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return HomeScreen(
                      onThemeChanged: onThemeChanged,
                      onBackgroundChanged: onBackgroundChanged,
                      onLanguageChanged: onLanguageChanged,
                      onColorChanged: onColorChanged,
                      onTextChanged: onTextChanged,
                    );
                  },
                ),
              );
            },
            title: Text(
              "Main page",
              style: TextStyle(
                color: AppConstants.textColor,
                fontSize: AppConstants.textSize,
              ),
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return SettingsScreen(
                      onThemeChanged: onThemeChanged,
                      onBackgroundChanged: onBackgroundChanged,
                      onLanguageChanged: onLanguageChanged,
                      onColorChanged: onColorChanged,
                      onTextChanged: onTextChanged,
                    );
                  },
                ),
              );
            },
            title: Text(
              "Settings",
              style: TextStyle(
                color: AppConstants.textColor,
                fontSize: AppConstants.textSize,
              ),
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return CourseAdminScreen(
                      onThemeChanged: onThemeChanged,
                      onBackgroundChanged: onBackgroundChanged,
                      onLanguageChanged: onLanguageChanged,
                      onColorChanged: onColorChanged,
                      onTextChanged: onTextChanged,
                    );
                  },
                ),
              );
            },
            title: Text(
              "Course",
              style: TextStyle(
                color: AppConstants.textColor,
                fontSize: AppConstants.textSize,
              ),
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PinScreen(
                      onThemeChanged: onThemeChanged,
                      onBackgroundChanged: onBackgroundChanged,
                      onLanguageChanged: onLanguageChanged,
                      onColorChanged: onColorChanged,
                      onTextChanged: onTextChanged,
                    );
                  },
                ),
              );
            },
            child: Text(
              'Log out',
              style: TextStyle(
                color: AppConstants.textColor,
                fontSize: AppConstants.textSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}