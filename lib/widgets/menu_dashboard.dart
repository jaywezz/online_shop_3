import 'package:flutter/material.dart';
import 'package:onlineshop3/models/cartData.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/services/auth.dart';
import 'package:onlineshop3/app_screens/cart.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/widgets/cart_icon.dart';
import 'package:provider/provider.dart';

Widget TopBarIcons(BuildContext context){
  final AuthService _auth = AuthService();
  final user = Provider.of<User>(context);




  return MultiProvider(
    providers: [
      StreamProvider<List<CartData>>.value(
          value: DatabaseService().cartProducts(user.uid))
    ],
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.white,),
            onPressed: (){},
          ),
         CartIcon()
        ],
      ),
    ),
  );

}
