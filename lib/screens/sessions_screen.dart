import 'package:flutter/material.dart';
import '../data/session_helper.dart';
import '../data/session.dart';
import '../shared/menu_bottom.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  List<Session> sessions = [];
  final TextEditingController textDescription = TextEditingController();
  final TextEditingController textDuration = TextEditingController();
  final SessionHelper sHelper = SessionHelper();

  @override
  void initState() {
    sHelper.init().then((value) {
      updateScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Training Sessions')),
      body: ListView(
        children: getContent(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showSessionDialog(context);
        },
      ),
      bottomNavigationBar: const MenuBottomNavBar(),
    );
  }

  Future<dynamic> showSessionDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a new session'),
            content: SingleChildScrollView(
              child: Column(children: [
                TextField(
                  controller: textDescription,
                  decoration: const InputDecoration(hintText: 'Description'),
                ),
                TextField(
                  controller: textDuration,
                  decoration: const InputDecoration(hintText: 'Duration'),
                ),
              ]),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    textDescription.clear();
                    textDuration.clear();
                  },
                  child: const Text('Cancel')),
              ElevatedButton(onPressed: saveSession, child: const Text('Save'))
            ],
          );
        });
  }

  Future saveSession() async {
    DateTime now = DateTime.now();
    String today = '${now.year}-${now.month}-${now.day}';
    int id = sHelper.getCounter() + 1;
    Session newSession = Session(
        id, today, textDescription.text, int.tryParse(textDuration.text) ?? 0);
    sHelper.writeSession(newSession).then((_) {
      updateScreen();
      sHelper.setCounter();
    });
    textDescription.clear();
    textDuration.clear();
    Navigator.pop(context);
  }

  List<Widget> getContent() {
    List<Widget> tiles = [];
    for (Session session in sessions) {
      tiles.add(Dismissible(
        key: UniqueKey(),
        onDismissed: ((_) {
          sHelper.deleteSession(session.id).then((value) => updateScreen());
        }),
        child: ListTile(
          title: Text(session.description),
          subtitle:
              Text('${session.date} - ${session.duration.toString()} min'),
        ),
      ));
    }
    return tiles;
  }

  void updateScreen() {
    sessions = sHelper.getSessions();
    setState(() {});
  }
}
