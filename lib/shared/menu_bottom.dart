import 'package:flutter/material.dart';

class MenuBottomNavBar extends StatelessWidget {
  const MenuBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.of(context).pushNamed('/');
            break;
          case 1:
            Navigator.of(context).pushNamed('/bmi');
            break;
          case 2:
            Navigator.of(context).pushNamed('/weather');
            break;
          case 3:
            Navigator.of(context).pushNamed('/training');
            break;
          default:
            Navigator.of(context).pushNamed('/');
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.monitor_weight), label: 'BMI'),
        BottomNavigationBarItem(
            icon: Icon(Icons.wb_twilight), label: 'Weather'),
        BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center), label: 'Training'),
      ],
    );
  }
}
