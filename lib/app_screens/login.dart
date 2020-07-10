
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onlineshop3/Animation/fade_animation.dart';
import 'package:onlineshop3/app_screens/home.dart';
import 'package:onlineshop3/app_screens/register.dart';
import 'package:onlineshop3/services/auth.dart';
import 'package:onlineshop3/widgets/google_login_button.dart';
import 'package:onlineshop3/widgets/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  String error = '';
  final _form_key = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  final  GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedIn = false;

  Future handleSignIn() async {
    print("we are here");
    FirebaseUser user;
    preferences = await SharedPreferences.getInstance();

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
    );
    user = (await firebaseAuth.signInWithCredential(credential)).user;
    if(user != null){
      final QuerySnapshot result = await Firestore
          .instance
          .collection("users").where("id", isEqualTo: user.uid).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if(documents.length == 0){
        //insert the new user
        Firestore.instance.collection("user").document(user.uid).setData({
          "id" : user.uid,
          "username" : user.displayName,
          "profilePicture" : user.photoUrl
        });

        await preferences.setString("id", user.uid);
        await preferences.setString("username", user.displayName);
        await preferences.setString("photoUrl", user.photoUrl);

      }else{
        await preferences.setString("id",documents[0]["id"]);
        await preferences.setString("username",documents[0]["username"]);
        await preferences.setString("photoUrl",documents[0]["photoUrl"]);
      }
      Fluttertoast.showToast(msg: "Logged In Successfully");
      setState(() {
        loading = false;
      });

    }else{

    }
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _form_key,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.white,
                height: 200,

                child: Stack(
                  children: <Widget>[

                    Positioned(
                      height: 200,
                      width: 250,
                      child: FadeAnimation(1.3, Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/login2.png'),
                                fit: BoxFit.fill
                            )
                        ),
                      )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(1.5, Text("Login", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),)),
                    SizedBox(height: 10,),
                    FadeAnimation(1.7, Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(196, 135, 198, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          ]
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(
                                    color: Colors.grey[200]
                                ))
                            ),
                            child: TextFormField(
                              validator: (value) => value.isEmpty ? 'Enter an email' : null,
                              onChanged: (value){
                                 setState(() {
                                   email = value;
                                 });
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Username",
                                  hintStyle: TextStyle(color: Colors.grey)
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              obscureText: true,
                              validator: (value) => value.length <6 ? 'Use a strong password for validation' : null,
                              onChanged: (value){
                                 setState(() {
                                   password = value;
                                 });
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey)
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                    SizedBox(height: 20,),
                    FadeAnimation(1.7, Center(child: Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),))),
                    SizedBox(height: 30,),
                    FadeAnimation(1.9, InkWell(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
                      },
                      child: InkWell(
                        onTap: () async{
                          if(_form_key.currentState.validate()){
                            try{
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth.signInWithEmailAndPassword(email, password).then((value){
                                setState(() {
                                  loading = false;
                                });
                              });
                            } catch(e){
                              setState(() {
                                loading = false;
                                error = e.message;
                              });
                              print("login exception");
                              print(e.message.toString());
                            }

                          }
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.deepOrange,
                          ),
                          child: Center(
                            child: Text("Login", style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                    )),
                    SizedBox(height: 10,),
                    FadeAnimation(2,Text(error,style: TextStyle(color: Colors.red),)),
                    SizedBox(height: 10,),

                    FadeAnimation(2,Container(
                      height: 55,
                      width: 250,
                      padding: EdgeInsets.all(10.0),
                      child: OutlineButton(
                        
                        splashColor: Colors.grey,
                        onPressed: () async {
                          try{
                            setState(() {
                              loading = true;
                            });
                            handleSignIn().then((value){
                              setState(() {
                                loading = false;
                              });
                            });
                          }catch(e){

                          }

                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        highlightElevation: 0,
                        borderSide: BorderSide(color: Colors.grey),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(image: AssetImage("assets/images/google_logo.png"), height: 35.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Sign in with Google',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),


                    FadeAnimation(2, InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));

                      },
                        child: Center(child: Text("Create Account", style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),))
                    )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );;
  }

}