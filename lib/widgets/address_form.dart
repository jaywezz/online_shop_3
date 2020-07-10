import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop3/Animation/fade_animation.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/models/userData.dart';
import 'package:provider/provider.dart';

class AddressForm extends StatefulWidget {
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _AddressformKey = GlobalKey<FormState>();
  TextEditingController _emailTextController =TextEditingController();
  TextEditingController _idTextController =TextEditingController();
  TextEditingController _phone_number_TextController =TextEditingController();
  TextEditingController _addressTextController =TextEditingController();
  TextEditingController _cityTextController =TextEditingController();

  String emaail;
  String address;
  int phone_number;
  int  id_no;
  String home_town;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final user_data= Provider.of<List<UserData>>(context) ?? [];

    return Form(
      key: _AddressformKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: _emailTextController,


                validator: null,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "email",
                    hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: _addressTextController,
                validator:null,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Address",
                    hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ),Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: _phone_number_TextController,
                validator: null,
                onChanged: (email){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Phone number",
                    hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: _idTextController,
                validator:null,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Id No.",
                    hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ),
            Container(

              padding: EdgeInsets.all(10),
              child: TextFormField(

                controller: _cityTextController,
                validator: null,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(

                    border: InputBorder.none,
                    hintText: "Home Town",
                    hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ),
            FadeAnimation(0.5, InkWell(
              onTap: (){

              },
              child: InkWell(
                onTap: () async{
                  if(_AddressformKey.currentState.validate()){
                    setState(() {
                    });
                    final Query cart_product = Firestore.instance
                        .collection('users').where("user_id", isEqualTo: user.uid);
                    cart_product.getDocuments().then((snaps) {
                      final String id_doc = snaps.documents[0].documentID;
                      print(id_doc);
                      try{
                        Firestore.instance.collection("users").document(id_doc).updateData({
                          "email": _emailTextController,
                          "address": _addressTextController.text,
                          "id_no": _idTextController.text,
                          "phone_number": _phone_number_TextController.text,
                          "city" : _cityTextController.text
                        });
                        Navigator.pop(context);


                      }catch(e){
                        print('there was an error updating info');
                        print(e.toString());
                      }
                    });
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
                    child: Text("Update", style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
