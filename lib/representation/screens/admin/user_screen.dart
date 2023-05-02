import 'package:flutter/material.dart';
import 'package:travel_app_ytb/representation/screens/admin/add_user_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/delete_user_screen.dart';

class AdminManageUser extends StatefulWidget {
  @override
  _AdminManageUserState createState() => _AdminManageUserState();
}

class _AdminManageUserState extends State<AdminManageUser> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    DeleteUserAccount(),
    AddUserScreen(),
    Text('Profile Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('User Management'), backgroundColor: Colors.green),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
                backgroundColor: Colors.yellow),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.blue,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
