import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_project/model/activitymodel.dart';
import 'package:demo_project/model/bookmodel.dart';
import 'package:demo_project/model/security.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Controller {
  // Instance of a firestore
  final db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future addUser(ScurityModel userModel, uid) async {
    // create collection
    final docRef = db.collection("security").doc(uid);
    //set or add values to collection
    docRef.set(userModel.data(docRef.id));
  }

  // Fetch single user
  ScurityModel? singleUserData;
  Future fetchSingleUser(id) async {
    final snapshot = await db.collection("user").doc(id).get();
    singleUserData = ScurityModel.fromData(snapshot.data()!);
  }

  Future logout() async {
    await _auth.signOut();
  }

  Future addBook(BookModel bookModel) async {
    final datajson = db.collection('Bookingdetails').doc();

    datajson.set(bookModel.toJsone(datajson.id));
  }

  List<BookModel>? bookModel = [];
  Future bookingdet(String type) async {
    final snapshot = await db
        .collection('Bookingdetails')
        .where("Type", isEqualTo: type)
        .get();

    return bookModel =
        snapshot.docs.map((e) => BookModel.fromJason(e.data())).toList();
    // log(bookModel!.length.toString());
  }

  Future addactivites(ActivityModel activityModel) async {
    final datajson = db.collection('AddingActivites').doc();

    datajson.set(activityModel.toJsone(datajson.id));
  }

  List<ActivityModel>? activityModel = [];
  Future adddet() async {
    final snapshot = await db.collection('AddingActivites').get();
    print(snapshot);
    log(snapshot.docs.length.toString());
 return   activityModel =
        snapshot.docs.map((e) => ActivityModel.fromJason(e.data())).toList();
    // log(bookModel!.length.toString());
    // log(activityModel!.length.toString());
  }
}
