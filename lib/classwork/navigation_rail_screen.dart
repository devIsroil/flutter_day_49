import 'package:flutter/material.dart';

///Reload usuli
class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List<Widget> pages = [
    Center(
      child: Text("Home"),
    ),
    Center(
      child: Text("Search"),
    ),
    Center(
      child: Text("Settings"),
    ),
  ];
  int selectedIndex = 0;

  void _onItemTapped(int i) {
    setState(() {
      selectedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation Rail"),
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
            elevation: 10,
            selectedIndex: selectedIndex,
            onDestinationSelected: _onItemTapped,
            labelType: NavigationRailLabelType.all,
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text("Home"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.search),
                label: Text("Search"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text("Settings"),
              ),
            ],
          ),
          Expanded(
            child: pages[selectedIndex],
          ),
        ],
      ),
    );
  }
}
