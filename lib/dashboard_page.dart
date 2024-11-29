import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class DashboardPage extends StatefulWidget {
  final String data;
  DashboardPage({super.key, required this.data});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  void _logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool('isLoggedIn', false);

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Logged Out")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard Page")),
      body: Center(
          child: Column(
        children: [
          Text("Welcome ${widget.data}"),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(onPressed: _logout, child: Text("Logout"))
        ],
      )),
    );
  }
}
