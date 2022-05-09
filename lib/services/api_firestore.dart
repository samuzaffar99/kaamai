// import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  var db = FirebaseFirestore.instance;
  late CollectionReference usersCol;
  late CollectionReference servicesCol;

  ApiService() {
    usersCol = db.collection("users");
    servicesCol = db.collection("services");
  }

  // get
  // Get List of documents(collection)
  Future<List<DocumentSnapshot>> getCollection(
      CollectionReference collectionRef) async {
    final QuerySnapshot<Object?> response = await collectionRef.get();
    return response.docs;
  }

  Future<List> getUsers() async {
    final response = await getCollection(usersCol);
    return response;
  }

  Future<List> getServices() async {
    final response = await getCollection(servicesCol);
    return response;
  }

  // Get single document by id
  Future<DocumentSnapshot> getDocument(DocumentReference docRef) async {
    final DocumentSnapshot<Object?> response = await docRef.get();
    return response;
  }

  Future<DocumentSnapshot> getUser(String id) async {
    final response = await getDocument(usersCol.doc(id));
    return response;
  }

  Future<DocumentSnapshot> getService(String id) async {
    final response = await getDocument(servicesCol.doc(id));
    return response;
  }

  // post
  // Create/Replace new document in database
  Future<DocumentReference> postDocument(
      CollectionReference col, Map data) async {
    final response = await col.add(data);
    return response;
  }

  Future<DocumentReference> postUser(Map<String, dynamic> data) async {
    final response = await postDocument(usersCol, data);
    return response;
  }

  Future<DocumentReference> postService(Map<String, dynamic> data) async {
    final response = await postDocument(servicesCol, data);
    return response;
  }

  //put
  // Modify document in database if exists, else create new
  Future<void> putDocument(DocumentReference docRef, Map data) async {
    Future<void> response = docRef.set(data, SetOptions(merge: true));
    return response;
  }

  Future<void> putUser(String id, Map data) async {
    final response = await putDocument(usersCol.doc(id), data);
    return response;
  }

  Future<void> putService(String id, Map data) async {
    final response = await putDocument(servicesCol.doc(id), data);
    return response;
  }

  //delete
  //Remove a document if it exists
  Future<void> delDocument(DocumentReference docRef) async {
    final response = await docRef.delete();
    return response;
  }

  Future<void> delUser(String id) async {
    final response = await delDocument(usersCol.doc(id));
    return response;
  }

  Future<void> delService(String id) async {
    final response = await delDocument(servicesCol.doc(id));
    return response;
  }

  Future<void> postReview(String id, Map data) async {
    Future<void> response = putService(id, data);
    return response;
  }
}
