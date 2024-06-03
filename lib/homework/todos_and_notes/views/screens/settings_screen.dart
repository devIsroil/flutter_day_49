import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../utils/app_constants.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/edit_text_alert_dialog.dart';
import '../widgets/password_alert_dialog.dart';

class SettingsScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onBackgroundChanged;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<Color> onColorChanged;
  final Function(Color, double) onTextChanged;

  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
    required this.onBackgroundChanged,
    required this.onLanguageChanged,
    required this.onColorChanged,
    required this.onTextChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _items = ['uz', 'rus', 'eng'];
  String? _selectedItem;
  Color _currentColor = AppConstants.appColor;

  void _openColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Color picker panel',
            style: TextStyle(
              color: AppConstants.textColor,
              fontSize: AppConstants.textSize,
            ),
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: (Color color) {
                _currentColor = color;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                widget.onColorChanged(_currentColor);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            color: AppConstants.textColor,
            fontSize: AppConstants.textSize,
          ),
        ),
        actions: [
          DropdownButton(
            hint: Text(AppConstants.language),
            value: _selectedItem,
            onChanged: (value) {
              widget.onLanguageChanged(value ?? '');
            },
            items: _items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      drawer: CustomDrawer(
        onThemeChanged: widget.onThemeChanged,
        onBackgroundChanged: widget.onBackgroundChanged,
        onLanguageChanged: widget.onLanguageChanged,
        onColorChanged: widget.onColorChanged,
        onTextChanged: widget.onTextChanged,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  AppConstants.imageUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SwitchListTile(
                value: AppConstants.themeMode == ThemeMode.dark,
                onChanged: widget.onThemeChanged,
                title: Text(
                  "Night mode",
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: AppConstants.textSize,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Your image url',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_textEditingController.text.isEmpty) {
                    widget.onBackgroundChanged(
                        'https://images.unsplash.com/photo-1500828131278-8de6878641b8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8bmF0dXJhbHxlbnwwfHwwfHx8MA%3D%3D');
                  } else {
                    widget.onBackgroundChanged(_textEditingController.text);
                  }
                  setState(() {});
                },
                icon: const Icon(Icons.save),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const PasswordAlertDialog();
                    },
                  );
                },
                child: Text(
                  'Change password',
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: AppConstants.textSize,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  _openColorPicker();
                },
                child: Text('Change color',
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: AppConstants.textSize,
                  ),),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditTextAlertDialog(
                      onTextChanged: widget.onTextChanged,
                    ),
                  );
                },
                child: Text('Change text style',
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: AppConstants.textSize,
                  ),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}