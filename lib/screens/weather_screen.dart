import 'package:flutter/material.dart';
import 'package:hello_world/data/weather.dart';
import 'package:hello_world/shared/menu_bottom.dart';
import '../data/http_helper.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController textCity = TextEditingController();
  Weather result = Weather('area', 'description...', 0, 0, 0, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: textCity,
                  decoration: InputDecoration(
                      labelText: 'City',
                      hintText: 'Enter a city',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.search_rounded),
                          onPressed: getWeather)),
                  onSubmitted: (String value) {
                    getWeather();
                  },
                )),
            weatherRow('Area', result.name),
            weatherRow('Description', result.description),
            weatherRow(
                'Temperature', '${result.temperature.toStringAsFixed(1)}°C'),
            weatherRow(
                'Feels Like', '${result.perceived.toStringAsFixed(1)}°C'),
            weatherRow('Humidity', '${result.humidity}%'),
            weatherRow('Preassure', '${result.pressure} hPa')
          ],
        ),
      ),
      bottomNavigationBar: const MenuBottomNavBar(),
    );
  }

  Future getWeather() async {
    HttpHelper helper = HttpHelper();
    result = await helper.getWeather(textCity.text);
    setState(() {});
  }

  Widget weatherRow(String label, String value) {
    Widget row = Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 20, color: Colors.black54),
                )),
            Expanded(
                flex: 4,
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 20, color: Colors.black87),
                )),
          ],
        ));
    return row;
  }
}
