import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:task/screens/dashboard.dart';
import 'package:task/services/auth.dart';
import 'package:task/services/db.dart';

class HomePage extends StatelessWidget {
  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:50.0),
              child: Image.asset("assets/images/undraw_Access_account_re_8spm.png"),
            ),
            Text("Connect with", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),),
            SizedBox(height: 10,),
            SignInButton(
              Buttons.Google, 
              onPressed: ()async{
                await _auth.signInwithGoogle();
                await fetchData(FirebaseAuth.instance.currentUser.uid);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successful")));
                Navigator.pushAndRemoveUntil(context, 
                MaterialPageRoute(builder: (context){
                  return MainPage();
                }), (route) => false);
              }
              ),
              SignInButton(
                Buttons.Facebook,
                onPressed: ()async{
                  await _auth.signInWithFacebook().then((value)async{
                    if(value!=null){
                      await fetchData(FirebaseAuth.instance.currentUser.uid);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successful")));
                      Navigator.pushAndRemoveUntil(context, 
                  MaterialPageRoute(builder: (context){
                    return MainPage();
                  }), (route) => false);
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error")));
                    }
                  });
                  
                },
              ),
          ],
        ),
    );
  }
}