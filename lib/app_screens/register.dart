import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlineshop3/Animation/fade_animation.dart';
import 'package:onlineshop3/app_screens/home_screen2.dart';
import 'package:onlineshop3/app_screens/login.dart';
import 'package:onlineshop3/app_screens/settings_screen.dart';
import 'package:onlineshop3/models/users.dart';
import 'package:onlineshop3/services/auth.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/widgets/loading.dart';
import 'package:onlineshop3/wrapper.dart';

import 'home.dart';
import 'home_screen.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;

  SignUp({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  UserServices _userServices = UserServices();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController =TextEditingController();
  TextEditingController _passwordTextController =TextEditingController();
  TextEditingController _nameTextController =TextEditingController();
  TextEditingController _confirmPasswordController =TextEditingController();


  String email = '';
  String error = '';
  String password = '';
  String gender = '';
  String groupalue = "male";
  bool hidePass = true;
  bool loading = false;
  @override
  Widget build(BuildContext context) {

    return loading? Loading() :Scaffold(

      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(1.5, Text("Register", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),)),
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
                              controller: _emailTextController,
                              validator: (value) => value.isEmpty ? 'Enter an email' : null,
                              onChanged: (value){
                                setState(() {
                                  email = value;
                                });
                              },
                              decoration: InputDecoration(

                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.grey)
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: _nameTextController,
                              validator: (value) => value.isEmpty ? 'Provide a your names' : null,
                              onChanged: (value){
                                setState(() {
                                  password = value;
                                });
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Full names",
                                  hintStyle: TextStyle(color: Colors.grey)
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: ListTile(
                                      title:Text(
                                        "male",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(color: Colors.black, fontSize: 12),),
                                      trailing:Radio(
                                          value: "male",

                                          groupValue: groupalue,
                                          onChanged: (e) => valueChanged(e)))),
                              Expanded(
                                  child: ListTile(
                                      title:Text(
                                        "female",

                                        style: TextStyle(color: Colors.black,fontSize: 12),),
                                      trailing:Radio(
                                          value: "female",
                                          groupValue: groupalue,
                                          onChanged: (e) => valueChanged(e)))),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: ListTile(
                              title: TextFormField(
                                controller: _passwordTextController,
                                validator: (value) {
                                  // ignore: missing_return
                                  if(value.isEmpty){
                                    return "The password field cannot be empty";
                                  } else if(value.length < 6){
                                    return "Password cannot be set less than 6 characters";
                                  }
                                  return null;
                                },
                                onChanged: (value){
                                  setState(() {
                                    password = value;
                                  });
                                },
                                obscureText: hidePass,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey)
                                ),
                              ),
                              trailing: IconButton(icon: Icon(Icons.remove_red_eye),iconSize: 18, onPressed: (){
                                if(hidePass){
                                  setState(() {
                                    hidePass = false;
                                  });
                                } else {
                                  setState(() {
                                    hidePass = true;
                                  });
                                }
                              },),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(
                                    color: Colors.grey[200]
                                ))
                            ),
                            child: ListTile(
                              title: TextFormField(
                                obscureText: hidePass,
                                controller: _confirmPasswordController,
                                validator: (value) {
                                  if(_passwordTextController.text != value)
                                  {
                                      return "Passwords did not match";
                                  }
                                },
                                onChanged: (value){
                                  setState(() {
                                    email = value;
                                  });
                                },
                                decoration: InputDecoration(

                                    border: InputBorder.none,
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(color: Colors.grey)
                                ),
                              ),
                              trailing: IconButton(icon: Icon(Icons.remove_red_eye),iconSize: 18, onPressed: (){
                                if(hidePass){
                                  setState(() {
                                    hidePass = false;
                                  });
                                } else {
                                  setState(() {
                                    hidePass = true;
                                  });
                                }
                              },),
                            ),
                          ),
                        ],
                      ),
                    )),

                    SizedBox(height: 20,),

                    FadeAnimation(1.9, InkWell(
                      onTap: (){

                        },
                      child: InkWell(
                        onTap: () async{
                          if(_formKey.currentState.validate()){
                            setState(() {

                              loading = true;
                            });
                            try{
                              dynamic result = await _auth.registerWithEmailAndPassword(_emailTextController.text, _passwordTextController.text).
                              then((user) => {
                                DatabaseService(uid: user.uid).updateUserData(_nameTextController.text, _emailTextController.text, gender, null).then((value) {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Wrapper())).then((value) =>  setState(() {

                                    loading = false;
                                  }));

                                }),
                               
                              });
                            } on PlatformException catch (e) {
                               setState(() {
                                 loading = false;
                               });
                                print("register exception");
                                print(e.message.toString());
                                setState(() {
                                  error = e.message.toString();
                                });

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
                            child: Text("Sign Up", style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                    )),
                    SizedBox(height: 10,),
                    FadeAnimation(2,Text(error,style: TextStyle(color: Colors.red),)),
                  

                    FadeAnimation(2, InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));

                        },

                        child: Center(child: Text("Login", style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),))
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

  valueChanged(e) {
    setState(() {
      if(e == "male"){
         groupalue = e;
         gender = e;
      }else if(e == "female"){
        groupalue = e;
        gender = e;
      }
    });
  }
  void validateForm() {
    FormState formState = _formKey.currentState;
    if(formState.validate()){

    }
  }
}
