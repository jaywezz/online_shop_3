import 'package:flutter/material.dart';
import 'package:onlineshop3/models/cartData.dart';
import 'package:provider/provider.dart';

class TopBarButtons extends StatefulWidget {
  @override
  _TopBarButtonsState createState() => _TopBarButtonsState();
}

class _TopBarButtonsState extends State<TopBarButtons> {
  @override
  Widget build(BuildContext context) {
//    final cartItems = Provider.of<CartData>(context);
    final cart= Provider.of<List<CartData>>(context);

    return Container();
  }
}
