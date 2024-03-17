import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  user,
  company,
  post,
  ;

  CollectionReference get reference => FirebaseFirestore.instance.collection(name);
}
