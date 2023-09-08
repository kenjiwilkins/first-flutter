import 'package:flutter/material.dart';
import 'package:hello_world/shared/menu_drawer.dart';
import '../shared/menu_bottom.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final TextEditingController textHeight = TextEditingController();
  final TextEditingController textWeight = TextEditingController();
  final double fontSize = 18;
  String result = '';
  bool isMetric = true;
  double? height;
  double? weight;
  late List<bool> isSelected;
  String heightMessage = '';
  String weightMessage = '';

  @override
  void initState() {
    isSelected = [isMetric, !isMetric];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightMessage = isMetric ? 'Height (cm)' : 'Height (in)';
    weightMessage = isMetric ? 'Weight (kg)' : 'Weight (lbs)';
    return Scaffold(
        appBar: AppBar(title: const Text('BMI Calculator')),
        drawer: const MenuDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(children: [
              ToggleButtons(
                  borderRadius: BorderRadius.circular(8),
                  isSelected: isSelected,
                  onPressed: handleSelected,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Metric',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Imperial',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ]),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: textHeight,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                      hintText: heightMessage,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: textWeight,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                      hintText: weightMessage,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8)),
                ),
              ),
              ElevatedButton(
                  onPressed: calculateBMI,
                  child: Text(
                    'Calculate BMI',
                    style: TextStyle(fontSize: fontSize),
                  )),
              Text(result, style: TextStyle(fontSize: fontSize)),
            ]),
          ),
        ),
        bottomNavigationBar: const MenuBottomNavBar());
  }

  void handleSelected(int index) {
    if (index == 0) {
      isMetric = true;
    } else {
      isMetric = false;
    }
    setState(() {
      isSelected = [isMetric, !isMetric];
    });
  }

  void calculateBMI() {
    double calHeight = double.tryParse(textHeight.text) ?? 0;
    double calWeight = double.tryParse(textWeight.text) ?? 0;
    double bmi = 0;
    if (isMetric) {
      bmi = calWeight / (calHeight * calHeight);
    } else {
      bmi = calWeight * 703 / (calHeight * calHeight);
    }

    setState(() {
      result = 'Your BMI is ${bmi.toStringAsFixed(2)}';
    });
  }
}
