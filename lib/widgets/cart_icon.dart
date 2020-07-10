import 'package:flutter/material.dart';
import 'package:onlineshop3/app_screens/cart.dart';
import 'package:onlineshop3/models/cartData.dart';
import 'package:provider/provider.dart';

class CartIcon extends StatefulWidget {
  @override
  _CartIconState createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  @override
  Widget build(BuildContext context) {
    final cart= Provider.of<List<CartData>>(context) ?? [];

    return  Stack(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.white,),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage()));

          },
        ),
        Positioned(
          top: 4,
          right: 9,
          child: Container(
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),

              child: Text(cart.length.toString(), style: TextStyle(color: Colors.white),)),
        )
      ],

    );
  }

}
