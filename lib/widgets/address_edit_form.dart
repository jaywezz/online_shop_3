
import 'package:flutter/material.dart';

import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/models/userData.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/widgets/address_form.dart';
import 'package:provider/provider.dart';

class AddressEditForm extends StatefulWidget {
  @override
  _AddressEditFormState createState() => _AddressEditFormState();
}

class _AddressEditFormState extends State<AddressEditForm> {



  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<UserData>>.value(
            value: DatabaseService().usersById(user.uid))
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.2,
          title: Text('Edit address details'),
          backgroundColor: Colors.black54,
        ),
        body: AddressForm()
      ),
    );
  }
}
