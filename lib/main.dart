import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/misc/Constants.dart';
import 'package:todo/ui/screen_done.dart';
import 'dart:developer' as developer;

final FirebaseAuth auth = FirebaseAuth.instance;
FirebaseUser currentUser;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  currentUser = await signInAnonymously();
  //developer.log('CurrentUser' + currentUser.email, name: 'main.dart');
  runApp(
      App()
  );
}

Future<FirebaseUser> signInAnonymously() async {
  final user = await auth.signInAnonymously();
  return user.user;
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Todo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(user: currentUser),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.user}) : super(key: key);
  final FirebaseUser user;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  final List<Widget> children = [DoneScreen(user: currentUser)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: currentIndex,
            fixedColor: Colors.deepPurple,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  title: Text(''), icon: Icon(FontAwesomeIcons.home)),
              BottomNavigationBarItem(
                  title: Text(''), icon: Icon(FontAwesomeIcons.calendarCheck)),
              BottomNavigationBarItem(
                  title: Text(''), icon: Icon(FontAwesomeIcons.slidersH))
            ]),
        body: children[currentIndex]);
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
