import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop3/models/orderData.dart';
import 'package:onlineshop3/models/userData.dart';
import 'package:provider/provider.dart';

class UserProfileWidget extends StatefulWidget {
  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController idController = TextEditingController();
  bool name_editing = false;
  bool email_editing = false;
  bool number_editing = false;
  bool address_editing = false;
  bool id_editing = false;

  final _nameform_key = GlobalKey<FormState>();
  final _emailform_key = GlobalKey<FormState>();
  final _numberform_key = GlobalKey<FormState>();
  final _addressform_key = GlobalKey<FormState>();
  final _idform_key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    int pending_orders;
    int succesful_orders;
    final user_data = Provider.of<List<UserData>>(context) ?? [];
    final orders_data = Provider.of<List<OrderData>>(context) ?? [];
    orders_data.forEach((order) {
      if(order.status == 'processing'){
      setState(() {
        pending_orders +1;
      });
      }else if(order.paid){
        setState(() {
          succesful_orders + 1;
        });
      }
    });
    return  Stack(
      children: <Widget>[
        SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.asset('assets/images/b2.jpg')
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.only(top: 16.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 96.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              !name_editing ? Row(
                                children: <Widget>[
                                  Text(
                                  user_data[0].names ?? 'No name',
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      setState(() {
                                        name_editing = true;
                                        nameController.text = user_data[0].names;
                                      });
                                    },
                                    icon: Icon(Icons.edit, color: Colors.deepOrangeAccent,),),
                                ],
                              ) :
                              Form(
                                key: _nameform_key,
                                child: Container(
                                  width: 280,
                                  child: Stack(

                                    children: <Widget>[
                                      Container(
                                        width: 240,
                                        child: TextFormField(
                                          keyboardType: TextInputType.numberWithOptions(),
                                          controller: nameController,
                                          validator: (name){
                                            print('you have printed ${name}');
                                            if(name.isEmpty){
                                              return 'Your name cannot be empty';
                                            }
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Full names"
                                          ),
                                        ),
                                      ),
                                      Positioned(

                                        right: 1,
                                        child: IconButton(
                                          onPressed: (){
                                            if(_nameform_key.currentState.validate()){
                                              final Query user_list = Firestore.instance
                                                  .collection('users').where("user_id", isEqualTo: user_data[0].user_id);
                                              user_list.getDocuments().then((snaps){
                                                print(snaps.documents.length);
                                                final String id_doc = snaps.documents[0].documentID;
                                                Firestore.instance.collection("users").document(id_doc).updateData({
                                                  "user_nane": nameController.text,

                                                });
                                              });
                                              setState(() {
                                                name_editing= false;
                                              });
                                            }

                                          },
                                          icon: Icon(Icons.check),tooltip: 'Update',color: Colors.green,),
                                      )
                                    ],
                                  ),
                                ),

                              ),
                              ListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text(user_data[0].email),
//                                subtitle: Text("Kathmandu"),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(orders_data.length.toString(), style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54
                                  ),),
                                  Text("Total orders")
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text('0',style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.deepOrangeAccent
                                  ) ),
                                  Text("Pending Orders", style: TextStyle(

                                      color: Colors.redAccent
                                  ))
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text('0',style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.green
                                  )),
                                  Text("Successful orders", style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green
                                  ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: AssetImage('assets/images/b2.jpg',),fit: BoxFit.cover)),
                    margin: EdgeInsets.only(left: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Your information"),

                    ),
                    Divider(),
                    !email_editing ? ListTile(
                      title: Text("Email"),
                      subtitle: Text(user_data[0].email),
                      leading: Icon(Icons.email, color: Colors.redAccent,),
                      trailing: IconButton(
                        onPressed: (){
                           setState(() {
                             email_editing = true;
                             emailController.text = user_data[0].email;
                           });
                        },
                        icon: Icon(Icons.edit, color: Colors.deepOrangeAccent,),),
                    ):
                    Form(
                      key: _emailform_key,
                      child: Container(
                        width: 280,
                        child: Stack(

                          children: <Widget>[
                            Container(
                              width: 240,
                              child: TextFormField(

                                controller: nameController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (name){
                                  print('you have printed ${name}');
                                  if(name.isEmpty){
                                    return 'Your email cannot be empty';
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: "Email"
                                ),
                              ),
                            ),
                            Positioned(

                              right: 1,
                              child: IconButton(
                                onPressed: (){
                                 if(_nameform_key.currentState.validate()){
                                   final Query user_list = Firestore.instance
                                       .collection('users').where("user_id", isEqualTo: user_data[0].user_id);
                                   user_list.getDocuments().then((snaps){
                                     print(snaps.documents.length);
                                     final String id_doc = snaps.documents[0].documentID;
                                     Firestore.instance.collection("users").document(id_doc).updateData({
                                       "email": nameController.text,

                                     });
                                   });
                                   setState(() {
                                     email_editing= false;
                                   });
                                 }

                                },
                                icon: Icon(Icons.check),tooltip: 'Update',color: Colors.green,),
                            )
                          ],
                        ),
                      ),

                    ),
                    !number_editing ?ListTile(
                      title: Text('Phone number') ,
                      subtitle: Text(user_data[0].phone_number ?? 'Provide phone number'),
                      leading: Icon(Icons.phone,color: Colors.redAccent),
                      trailing: IconButton(
                        onPressed: (){
                          setState(() {
                            number_editing = true;
                            phoneController.text = user_data[0].phone_number;
                          });
                        },
                        icon: Icon(Icons.edit, color: Colors.deepOrangeAccent,),),
                    ) :
                    Form(
                      key: _numberform_key,
                      child: Container(
                        width: 280,
                        child: Stack(

                          children: <Widget>[
                            Container(
                              width: 240,
                              child: TextFormField(

                                controller: phoneController,
                                keyboardType: TextInputType.numberWithOptions(),
                                validator: (number){

                                  if(number.isEmpty){
                                    return 'Your number cannot be empty';
                                  }else if(number.length < 10 || number.length > 12 ){
                                    return 'Proide a valid number with format 254';
                                  }else if(number[0] == '0'){
                                    return 'Provide a number with format 254';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Phone number"
                                ),
                              ),
                            ),
                            Positioned(

                              right: 1,
                              child: IconButton(
                                onPressed: (){
                                  if(_numberform_key.currentState.validate()){
                                    final Query user_list = Firestore.instance
                                        .collection('users').where("user_id", isEqualTo: user_data[0].user_id);
                                    user_list.getDocuments().then((snaps){
                                      print(snaps.documents.length);
                                      final String id_doc = snaps.documents[0].documentID;
                                      Firestore.instance.collection("users").document(id_doc).updateData({
                                        "phone_number": phoneController.text,

                                      });
                                    });
                                    setState(() {
                                      number_editing= false;
                                    });
                                  }

                                },
                                icon: Icon(Icons.check),tooltip: 'Update',color: Colors.green,),
                            )
                          ],
                        ),
                      ),

                    ),

                    !address_editing ? ListTile(
                      title: Text("Address"),
                      subtitle: Text(user_data[0].address ?? 'Provide an address'),
                      leading: Icon(Icons.my_location, color: Colors.redAccent),
                      trailing: IconButton(
                        onPressed: (){
                          setState(() {
                            address_editing = true;
                            addressController.text = user_data[0].address;
                          });
                        },
                        icon: Icon(Icons.edit, color: Colors.deepOrangeAccent,),),
                    ) :
                    Form(
                      key: _addressform_key,
                      child: Container(
                        width: 280,
                        child: Stack(

                          children: <Widget>[
                            Container(
                              width: 240,
                              child: TextFormField(

                                controller: addressController,
                                validator: (name){
                                  print('you have printed ${name}');
                                  if(name.isEmpty){
                                    return 'Your email cannot be empty';
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: "Address"
                                ),
                              ),
                            ),
                            Positioned(

                              right: 1,
                              child: IconButton(
                                onPressed: (){
                                  if(_addressform_key.currentState.validate()){
                                    final Query user_list = Firestore.instance
                                        .collection('users').where("user_id", isEqualTo: user_data[0].user_id);
                                    user_list.getDocuments().then((snaps){
                                      print(snaps.documents.length);
                                      final String id_doc = snaps.documents[0].documentID;
                                      Firestore.instance.collection("users").document(id_doc).updateData({
                                        "address": addressController.text,

                                      });
                                    });
                                    setState(() {
                                      address_editing= false;
                                    });
                                  }

                                },
                                icon: Icon(Icons.check),tooltip: 'Update',color: Colors.green,),
                            )
                          ],
                        ),
                      ),

                    ),
                    !id_editing ? ListTile(
                      title: Text("Id No."),
                      subtitle: Text(user_data[0].id_no ?? 'Provide an Id No.'),
                      leading: Icon(Icons.person, color: Colors.redAccent),
                      trailing: IconButton(
                        onPressed: (){
                          setState(() {
                            id_editing = true;
                            idController.text = user_data[0].id_no;
                          });
                        },
                        icon: Icon(Icons.edit, color: Colors.deepOrangeAccent,),),
                    ) :
                    Form(
                      key: _idform_key,
                      child: Container(
                        width: 280,
                        child: Stack(

                          children: <Widget>[
                            Container(
                              width: 240,
                              child: TextFormField(
                                keyboardType: TextInputType.numberWithOptions(),
                                controller: idController,
                                validator: (name){
                                  print('you have printed ${name}');
                                  if(name.isEmpty){
                                    return 'Your id cannot be empty';
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: "Id No."
                                ),
                              ),
                            ),
                            Positioned(

                              right: 1,
                              child: IconButton(
                                onPressed: (){
                                  if(_idform_key.currentState.validate()){
                                    final Query user_list = Firestore.instance
                                        .collection('users').where("user_id", isEqualTo: user_data[0].user_id);
                                    user_list.getDocuments().then((snaps){
                                      print(snaps.documents.length);
                                      final String id_doc = snaps.documents[0].documentID;
                                      Firestore.instance.collection("users").document(id_doc).updateData({
                                        "id_no": idController.text,

                                      });
                                    });
                                    setState(() {
                                      id_editing= false;
                                    });
                                  }

                                },
                                icon: Icon(Icons.check),tooltip: 'Update',color: Colors.green,),
                            )
                          ],
                        ),
                      ),

                    ),
                    ListTile(
                      title: Text("Payment Method"),
                      subtitle: Text(user_data[0].payment_method),
                      leading: Icon(Icons.account_balance_wallet, color: Colors.redAccent),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        )
      ],
    );
  }
}
