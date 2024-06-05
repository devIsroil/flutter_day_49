import 'package:flutter/material.dart';
import 'package:flutter_lesson_49/homework/todos_and_notes/views/screens/profile_screen.dart';
import 'package:flutter_lesson_49/homework/todos_and_notes/views/screens/results_screen.dart';

import '../../utils/app_constants.dart';
import '../widgets/custom_drawer.dart';
import 'main_screen.dart';


class HomeScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onBackgroundChanged;
  final ValueChanged<String> onLanguageChanged;
  final ValueChanged<Color> onColorChanged;
  final Function(Color, double) onTextChanged;

  const HomeScreen({
    super.key,
    required this.onThemeChanged,
    required this.onBackgroundChanged,
    required this.onLanguageChanged,
    required this.onColorChanged,
    required this.onTextChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = <Widget>[
    MainScreen(),
    const ResultsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          bool isMobile = constraints.maxWidth < 600;
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  AppConstants.imageUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text(
                  "Main page",
                  style: TextStyle(
                    color: AppConstants.textColor,
                    fontSize: AppConstants.textSize,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(AppConstants.language),
                  ),
                ],
              ),
              body: Row(
                children: [
                  if (!isMobile)
                    NavigationRail(
                      backgroundColor: Colors.blue,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.home),
                          label: Text('Main'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.stacked_bar_chart_sharp),
                          label: Text('Results'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.person),
                          label: Text('Profile'),
                        ),
                      ],
                      labelType: NavigationRailLabelType.selected,
                      onDestinationSelected: (int value) =>
                          setState(() => _currentIndex = value),
                      selectedIndex: _currentIndex,
                    ),
                  Expanded(child: _pages[_currentIndex])
                ],
              ),
              drawer: CustomDrawer(
                onThemeChanged: widget.onThemeChanged,
                onBackgroundChanged: widget.onBackgroundChanged,
                onLanguageChanged: widget.onLanguageChanged,
                onColorChanged: widget.onColorChanged,
                onTextChanged: widget.onTextChanged,
              ),

              bottomNavigationBar: isMobile
                  ? BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: _currentIndex,
                onTap: (i) => setState(() => _currentIndex = i),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Main",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.stacked_bar_chart_sharp),
                    label: 'Results',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              )
                  : null,


            ),
          );
        });
  }
}
