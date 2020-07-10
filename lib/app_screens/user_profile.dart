

import 'package:flutter/material.dart';
import 'package:onlineshop3/models/orderData.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/models/userData.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/widgets/user_profile_widget.dart';
import 'package:provider/provider.dart';

class ProfileThreePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<UserData>>.value(
            value:DatabaseService().usersById(user.uid),
        ),
        StreamProvider<List<OrderData>>.value(
            value:DatabaseService().ordersByUID(user.uid)
        ),
      ],
      child: SingleChildScrollView(
          child: UserProfileWidget()
        ),

    );
  }
}
