import 'package:shared_preferences/shared_preferences.dart';
import './session.dart';
import 'dart:convert';

class SessionHelper {
  static late SharedPreferences _preferences;

  Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future writeSession(Session session) async {
    _preferences.setString(
        session.id.toString(), json.encode(session.toJson()));
  }

  List<Session> getSessions() {
    List<Session> sessions = [];
    Set<String> keys = _preferences.getKeys();
    for (String key in keys) {
      if (key != 'counter') {
        Session session =
            Session.fromJson(jsonDecode(_preferences.getString(key) ?? ''));
        sessions.add(session);
      }
    }
    return sessions;
  }

  Future setCounter() async {
    int counter = _preferences.getInt('counter') ?? 0;
    counter++;
    await _preferences.setInt('counter', counter);
  }

  int getCounter() {
    return _preferences.getInt('counter') ?? 0;
  }

  Future deleteSession(int id) async {
    await _preferences.remove(id.toString());
  }
}
