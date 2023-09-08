import 'package:flutter/material.dart';
import '../screens/intro_screen.dart';
import '../screens/bmi_screen.dart';
import '../screens/weather_screen.dart';
import '../screens/sessions_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: buildMenuItems(context),
    ));
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTitles = [
      'Home',
      'BMI Calculator',
      'Weather',
      'Training'
    ];
    List<Widget> menuItems = [];
    menuItems.add(const DrawerHeader(
      decoration: BoxDecoration(color: Colors.blueGrey),
      child: Text('Hello World',
          style: TextStyle(color: Colors.white, fontSize: 24)),
    ));
    for (var titleElement in menuTitles) {
      Widget screen = Container();
      menuItems.add(ListTile(
        title: Text(titleElement, style: const TextStyle(fontSize: 18)),
        onTap: () {
          switch (titleElement) {
            case 'Home':
              screen = const IntroScreen();
              break;
            case 'BMI Calculator':
              screen = const BmiScreen();
              break;
            case 'Weather':
              screen = const WeatherScreen();
              break;
            case 'Training':
              screen = const SessionScreen();
              break;
            default:
              screen = const IntroScreen();
          }
          Navigator.pop(context);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => screen));
        },
      ));
    }
    return menuItems;
  }
}
