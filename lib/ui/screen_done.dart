import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/model/task.dart';
import 'package:todo/misc/constants.dart' as Constants;

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
          getToolbar(context),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Task',
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Done',
                            style:
                                TextStyle(fontSize: 28.0, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 175.0),
            child: Container(
              height: 360.0,
              padding: EdgeInsets.only(bottom: 25.0),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                },
                child: StreamBuilder<QuerySnapshot>(
                    stream: Constants.collectionOfFirestore(
                            widget.user, Constants.DATE, true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.blue,
                          ),
                        );
                      return ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(left: 40.0, right: 40.0),
                        scrollDirection: Axis.horizontal,
                        children: getItems(snapshot),
                      );
                    }),
              ),
            ),
          )
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
              image: AssetImage('asset/images/list.png'))
        ],
      ),
    );
  }

  List<Widget> getItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    if (widget.user.uid.isEmpty) return null;

    List<Task> items = List(), temp;
    Map<String, List<Task>> documents = Map();
    List<String> colors = new List();

    snapshot.data.documents.map<List>((document) {
      document.data.forEach((key, value) {
        if (value.runtimeType == bool) {
          items.add(Task(key, value));
        } else if (value.runtimeType == String && key == Constants.COLOR) {
          colors.add(value);
        }

        temp = List<Task>.from(items);
        documents[document.documentID] = temp;

        for (int index = 0; index < temp.length; index++) {
          if (temp.elementAt(index).done == false) {
            documents.remove(document.documentID);
            if (colors.isNotEmpty) colors.removeLast();
            break;
          }
        }

        if (temp.isEmpty) {
          documents.remove(document.documentID);
          colors.removeLast();
        }
        items.clear();
      });
    });

    return List.generate(documents.length, (int index) {
      return GestureDetector(
        onTap: onTaskTapped,
        child: getCard(index, colors),
      );
    });
  }

  void onTaskTapped() {}

  Card getCard(Task task, String color) {
    return Card(
      shape: RoundedRectangleBorder(

      ),
      color: Color(int.parse(color)),
      child: Container(
        width: 220.0,
      ),
    );
  }
}
