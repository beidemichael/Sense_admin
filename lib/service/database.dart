import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/models.dart';

class DatabaseService {
  String? userUid;
  String? id;
  int? index;
  String? email;
  DatabaseService({this.userUid, this.index, this.id, this.email});

  final CollectionReference newsCollection =
      FirebaseFirestore.instance.collection('News');
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('Category');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  List category = [];

  Future publishNews(
    String headline,
    String description,
    String image,
    List categories,
    String author,
    bool active,
  ) async {
    newsCollection
        .add({
          'Headline': headline,
          'Description': description,
          'Image': image,
          'Categories': categories,
          'Active': active,
          'Created': Timestamp.now(),
          'Author': author,
        })
        .then((value) => print("News Added"))
        .catchError((error) => print("Failed to add News: $error"));
  }

  Future updateNews(
    String headline,
    String description,
    String image,
    String docUid,
  ) async {
    newsCollection
        .doc(docUid)
        .update({
          'Headline': headline,
          'Description': description,
          'Image': image,
          'Active': true,
        })
        .then((value) => print("News Added"))
        .catchError((error) => print("Failed to add News: $error"));
  }

  Future publishCategory() async {
    categoryCollection
        .add({})
        .then((value) => print("category Added"))
        .catchError((error) => print("Failed to add category: $error"));
  }

  Future newUser(User? user) async {
    userCollection
        .doc(user?.uid)
        .set({
          'displayName': user?.displayName,
          'email': user?.email,
          'isAnonymous': user?.isAnonymous,
          'phoneNumber': user?.phoneNumber,
          'photoURL': user?.photoURL,
          'uid': user?.uid
        })
        .then((value) => print("category Added"))
        .catchError((error) => print("Failed to add category: $error"));
  }

  List<UserInformation> _userInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserInformation(
        displayName: (doc.data() as dynamic)['displayName'] ?? '',
        email: (doc.data() as dynamic)['email'] ?? '',
        isAnonymous: (doc.data() as dynamic)['isAnonymous'] ?? false,
        phoneNumber: (doc.data() as dynamic)['phoneNumber'] ?? '',
        photoURL: (doc.data() as dynamic)['photoURL'] ?? '',
          isAdmin: (doc.data() as dynamic)['admin'] ?? false,
        uid: (doc.data() as dynamic)['uid'] ?? '',
      );
    }).toList();
  }

  List<AdminInformation> _adminInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return AdminInformation(
        displayName: (doc.data() as dynamic)['displayName'] ?? '',
        email: (doc.data() as dynamic)['email'] ?? '',
        isAnonymous: (doc.data() as dynamic)['isAnonymous'] ?? '',
        phoneNumber: (doc.data() as dynamic)['phoneNumber'] ?? '',
        photoURL: (doc.data() as dynamic)['photoURL'] ?? '',
        isAdmin: (doc.data() as dynamic)['admin'] ?? false,
        uid: (doc.data() as dynamic)['uid'] ?? '',
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<UserInformation>> get userInfo {
    return userCollection
        .where('uid', isEqualTo: userUid)
        .snapshots()
        .map(_userInfoListFromSnapshot);
  }

  Stream<List<UserInformation>> get usersList {
    return userCollection.snapshots().map(_userInfoListFromSnapshot);
  }

  Stream<List<AdminInformation>> get adminInfo {
    return userCollection
        .where('admin', isEqualTo: true)
        .snapshots()
        .map(_adminInfoListFromSnapshot);
  }
   Stream<List<AdminInformation>> get searchAdmin {
    return userCollection
        .where('email', isEqualTo: email)
        .snapshots()
        .map(_adminInfoListFromSnapshot);
  }

  Future makeAdmin(
    String docUid,
  ) async {
    userCollection.doc(docUid).update({
      'admin': true,
    });
  }
    Future updateAdmin(
    String docUid,
  ) async {
    userCollection.doc(docUid).update({
      'admin': false,
    });
  }

  List<News> _newsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return News(
        headline: (doc.data() as dynamic)['Headline'] ?? '',
        description: (doc.data() as dynamic)['Description'] ?? '',
        image: (doc.data() as dynamic)['Image'] ?? '',
        categories: (doc.data() as dynamic)['Categories'] ?? [],
        bookmarks: (doc.data() as dynamic)['bookMarkedBy'] ?? [],
        readerList: (doc.data() as dynamic)['readerList'] ?? [],
        active: (doc.data() as dynamic)['Active'] ?? false,
        created: (doc.data() as dynamic)['Created'] ?? '',
        author: (doc.data() as dynamic)['Author'] ?? '',
        documentId: doc.reference.id,
      );
    }).toList();
  }

  //News
  Stream<List<News>> get news {
    return newsCollection
        .orderBy('Created', descending: true)
        .snapshots()
        .map(_newsListFromSnapshot);
  }

  Future deleteNews(
    String docUid,
  ) async {
    newsCollection.doc(docUid).delete();
  }

  Future newsActiveState(
    String docUid,
    bool state,
  ) async {
    newsCollection.doc(docUid).update({
      'Active': !state,
    });
  }

  List<NewsCategory> listFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return NewsCategory(
        category: (doc.data() as dynamic)['Categories'] ?? [],
        documentId: doc.reference.id,
      );
    }).toList();
  }

  //orders lounges stream
  Stream<List<NewsCategory>> get newsCategory {
    return categoryCollection.snapshots().map(listFromSnapshot);
  }

  Future addNewCategory(
    String? name,
  ) async {
    categoryCollection.doc(id).get().then((document) {
      category = (document.data() as dynamic)['Categories'] ?? [];

      category.add(name);

      categoryCollection.doc(id).update({
        'Categories': category,
      });
    });
  }

  Future removeCategory(
    String name,
  ) async {
    categoryCollection.doc(id).get().then((document) {
      category = (document.data() as dynamic)['Categories'] ?? [];

      category.remove(name);

      categoryCollection.doc(id).update({
        'Categories': category,
      });
    });
  }

  Future updateCategory(
    String name,
  ) async {
    categoryCollection.doc(id).get().then((document) {
      category = (document.data() as dynamic)['Categories'] ?? [];

      category[index!] = name;

      categoryCollection.doc(id).update({
        'Categories': category,
      });
    });
  }
}
