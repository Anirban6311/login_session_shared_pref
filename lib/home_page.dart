import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoggedIn = false;

  late SharedPreferences pref;
  initSharedPreferences() async {
    pref = await SharedPreferences.getInstance();
    loadPrefs();
  }

  @override
  void initState() {
    initSharedPreferences();
    super.initState();
  }

  void loadPrefs() {
    setState(() {
      isLoggedIn = pref.getBool('isLoggedIn')!;
    });

    if (isLoggedIn) {
      // Automatically navigate to Dashboard if logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(data: "Anirban Sinha Roy"),
        ),
      );
    }
  }

  void verifyUserLogin(
      BuildContext context,
      TextEditingController _emailController,
      TextEditingController _passwordController) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email == "asinha@gmail.com" && password == "abcdef") {
      await pref.setBool('isLoggedIn', true);
      setState(() {
        isLoggedIn = true;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DashboardPage(data: "Anirban Sinha Roy")),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login Successfull")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login Failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Enter your email',
            prefixIcon: const Icon(Icons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            filled: true,
            fillColor: Colors.grey[200],
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        // Password TextField
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Enter your password',
            prefixIcon: const Icon(Icons.lock),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            filled: true,
            fillColor: Colors.grey[200],
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
          ),
          obscureText: true,
        ),

        const SizedBox(
          height: 50,
        ),
        ElevatedButton(
            onPressed: () {
              verifyUserLogin(context, _emailController, _passwordController);
            },
            child: const Text("Login"))
      ],
    ));
  }
}
