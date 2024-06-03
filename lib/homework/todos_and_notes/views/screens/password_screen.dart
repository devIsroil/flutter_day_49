import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app_constants.dart';
import 'home_screen.dart';

class PinScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onBackgroundChanged;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<Color> onColorChanged;
  final Function(Color, double) onTextChanged;

  const PinScreen({
    super.key,
    required this.onThemeChanged,
    required this.onBackgroundChanged,
    required this.onLanguageChanged,
    required this.onColorChanged,
    required this.onTextChanged,
  });

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  List<TextEditingController> _textEditingControllersList = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  for (int i = 0; i < _textEditingControllersList.length; i++)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _textEditingControllersList[i],
                          maxLength: 1,
                          onChanged: (value) {
                            FocusScope.of(context).nextFocus();
                          },
                          decoration: InputDecoration(
                            counterText: '',
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Text(errorMessage),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  errorMessage = '';

                  List<String> password = AppConstants.password.split('');
                  for (int i = 0; i < _textEditingControllersList.length; i++) {
                    if (password[i] != _textEditingControllersList[i].text) {
                      errorMessage = 'Invalid password';
                      break;
                    }
                  }
                  if (errorMessage.isEmpty) {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) {
                          return HomeScreen(
                            onThemeChanged: widget.onThemeChanged,
                            onBackgroundChanged: widget.onBackgroundChanged,
                            onLanguageChanged: widget.onLanguageChanged,
                            onColorChanged: widget.onColorChanged,
                            onTextChanged: widget.onTextChanged,
                          );
                        },
                      ),
                    );
                  }
                  setState(() {});
                },
                child: Text('Next Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}