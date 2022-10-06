class Category {
  final int id;
  final String cat;

  Category({
    required this.id,
    required this.cat,
  });
}

class UserAuth {
  final String uid;
  UserAuth({required this.uid});
}

class UserInformation {
  String displayName;
  String email;
  bool isAnonymous;
  String phoneNumber;
  String photoURL;
  bool isAdmin;
  String uid;

  UserInformation({
    required this.displayName,
    required this.email,
    required this.isAnonymous,
    required this.phoneNumber,
    required this.photoURL,
    required this.isAdmin,
    required this.uid,
  });
}

class AdminInformation {
  String displayName;
  String email;
  bool isAnonymous;
  String phoneNumber;
  String photoURL;
  String uid;
  bool isAdmin;

  AdminInformation({
    required this.displayName,
    required this.email,
    required this.isAnonymous,
    required this.phoneNumber,
    required this.photoURL,
    required this.uid,
    required this.isAdmin,
  });
}

class News {
  String headline;
  String description;
  String image;
  List categories;
  List bookmarks;
  bool active;
  var created;
  String author;
  String documentId;
  List readerList;
  News({
    required this.active,
    required this.author,
    required this.categories,
    required this.created,
    required this.description,
    required this.headline,
    required this.image,
    required this.documentId,
    required this.bookmarks,
    required this.readerList,
  });
}

class NewsCategory {
  List category;
  String documentId;
  NewsCategory({
    required this.category,
    required this.documentId,
  });
}

typedef void StringCallback(String val);
