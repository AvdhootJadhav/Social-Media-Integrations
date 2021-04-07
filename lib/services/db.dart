
import 'package:cloud_firestore/cloud_firestore.dart';

String name="", email="", imageUrl="";


Future addGoogleUser(String uid, String name, String email, String imageUrl)async{
  return FirebaseFirestore.instance.collection("Users").doc(uid).set({
    "Username":name,
    "Email":email,
    "ImageUrl":imageUrl,
  });
}

Future<void> addFacebookUser(String uid, String name, String email, String profileimg) async {
  return await FirebaseFirestore.instance.collection("Users").doc(uid).set({
    'Username': name,
    'Email': email,
    'ImageUrl': profileimg,
  });
}

Future fetchData(String uid)async{
  return await FirebaseFirestore.instance.collection("Users").doc(uid)
  .get().then((value){
    name=value.get("Username");
    email=value.get("Email");
    imageUrl=value.get("ImageUrl");    
  });
}