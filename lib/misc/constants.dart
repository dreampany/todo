library Constants;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/**
 * Created by roman on 2019-11-27
 * Copyright (c) 2019 bjit. All rights reserved.
 * hawladar.roman@bjitgroup.com
 * Last modified $file.lastModified
 */
/*class Constants extends InheritedWidget {

  static Constants of (BuildContext  context) => context.inheritFromWidgetOfExactType(Constants);

  const Constants({Widget child, Key key}): super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}*/

const String TODO = "todo";
const String DATA = "data";
const String DATE = "date";
const String COLOR = "color";

CollectionReference collectionOfFirestore(FirebaseUser user, String orderBy, bool descending) {
  return Firestore.instance.collection(TODO).document(DATA)
      .collection(user.uid).orderBy(orderBy, descending: descending);
}