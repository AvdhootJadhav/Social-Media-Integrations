
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task/screens/homepage.dart';
import 'package:task/services/auth.dart';
import 'package:task/services/db.dart';

class MainPage extends StatelessWidget {
  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Details", style: TextStyle(color: Colors.white),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:5.0),
            child: GestureDetector(child: Icon(Icons.logout), onTap: (){
              _auth.signOutGoogle();
              _auth.signOutFB();
              Navigator.pushAndRemoveUntil(context, 
              MaterialPageRoute(builder: (context){
                return HomePage();
              }), (route) => false);
            },),
          )
        ],
      ),
      body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 15,),
                          ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(65),
                            ),
                            child: Image.network(imageUrl,
                            fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Username: "+name, style: TextStyle(fontSize: 15),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Email: "+email,style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}