import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**
 * Created by roman on 2019-11-26
 * Copyright (c) 2019 bjit. All rights reserved.
 * hawladar.roman@bjitgroup.com
 * Last modified $file.lastModified
 */

class DoneScreen extends StatefulWidget {
  final FirebaseUser user;

  DoneScreen({Key key, this.user}) : super(key: key);

  @override
  DoneScreenState createState() => DoneScreenState();

}

class DoneScreenState extends State<DoneScreen>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          getToolbar(context)
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Padding getToolbar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
              width: 40.0,
              height: 40.0,
              fit: BoxFit.cover,
              image: AssetImage('assets/list.png')
          )
        ],
      ),
    );
  }
}