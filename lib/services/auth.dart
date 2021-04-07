import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task/services/db.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class AuthService{

  String image;
  String username;

  Future signInwithGoogle() async{
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await FirebaseAuth.instance.signInWithCredential(credential);
    final user = authResult.user;
    if(user!=null){
      assert(user.email!=null);
      assert(user.displayName!=null);
      assert(user.photoURL!=null);
      image = user.photoURL;
      username = user.displayName;
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = FirebaseAuth.instance.currentUser;
      assert(user.uid == currentUser.uid);
      addGoogleUser(FirebaseAuth.instance.currentUser.uid, username, user.email, image);
      print("SignIn Success");
    }
  }

  Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
  }

  signInWithFacebook() async{
    final result = await FacebookAuth.instance.login();
    final FacebookAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.token);
    final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    final User user = authResult.user;
    final token = facebookAuthCredential.accessToken;
    final graphResponse = await http.get(
    'https://graph.facebook.com/v2.12/me?fields=name,picture.width(100).height(100),first_name,last_name,email&access_token=$token');
    Map userresult;
    final profile = JSON.jsonDecode(graphResponse.body);
    if (user != null) {
      // Checking if email and name is null
      //assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);

      username = user.displayName;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = FirebaseAuth.instance.currentUser;
      assert(user.uid == currentUser.uid);

      userresult=profile;

      addFacebookUser(user.uid, user.displayName, user.email, userresult["picture"]["data"]["url"]);
      print('signInWithFacebbok succeeded: $user');
      print('Imageurl: ${userresult["picture"]["data"]["url"]}');
      return '${user.uid}';
     }
     return null;
}

  Future<void> signOutFB() async {
    await FacebookAuth.instance.logOut();
  }
}