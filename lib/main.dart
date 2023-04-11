import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class Global {
  static String smoke = 'Add';
}

class Adding extends StatefulWidget {
  @override
  State<Adding> createState() => _AddingState();
}

class _AddingState extends State<Adding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smoke'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 1.0,
        height: MediaQuery.of(context).size.height * 1.0,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Global.smoke = 'Yes';
                Provider.of<MyState>(context, listen: false).smoke = Global.smoke;

              },
              child: Text('Yes'),
            ),
            ElevatedButton(
              onPressed: () {
                Global.smoke = 'No';
                Provider.of<MyState>(context, listen: false).smoke = Global.smoke;

              },
              child: Text('No'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyState with ChangeNotifier {
  String _smoke = 'Add';

  String get smoke => _smoke;

  set smoke(String value) {
    _smoke = value;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyState(),
      child: MaterialApp(
        home: BackProblem(),
      ),
    );
  }
}

class BackProblem extends StatefulWidget {
  @override
  State<BackProblem> createState() => _BackProblemState();
}

class _BackProblemState extends State<BackProblem> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<MyState>(context, listen: false).smoke = Global.smoke;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Preferences'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width * 1.0,
          height: MediaQuery.of(context).size.height * 1.0,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.smoking_rooms),
                title: Text('Smoke'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Provider.of<MyState>(context).smoke,
                    ),
                    IconButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Adding(),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
