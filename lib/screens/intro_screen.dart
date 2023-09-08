import 'package:flutter/material.dart';
import 'package:hello_world/shared/menu_bottom.dart';
import 'package:hello_world/shared/menu_drawer.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello, World'),
        centerTitle: false,
      ),
      drawer: const MenuDrawer(),
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/hello.jpg'), fit: BoxFit.cover)),
          child: Center(
              child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white70,
                  ),
                  child: const Text(
                    'Hello, \nWorld',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, shadows: [
                      Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 2.0,
                          color: Colors.grey)
                    ]),
                  )))),
      bottomNavigationBar: const MenuBottomNavBar(),
    );
  }
}
