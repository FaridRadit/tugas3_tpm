import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas3/pages/login_page.dart';
class HomePage extends StatelessWidget {
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? 'Guest';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: FutureBuilder<String>(
          future: getUsername(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome, ${snapshot.data}!"),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => logout(context),
                  child: const Text("Logout"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
