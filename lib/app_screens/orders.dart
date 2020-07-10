import 'package:flutter/material.dart';
import 'package:onlineshop3/models/cartData.dart';
import 'package:onlineshop3/models/orderData.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/widgets/orderList.dart';
import 'package:provider/provider.dart';

class AllOrders extends StatefulWidget {
  @override
  _AllOrdersState createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<OrderData>>.value(
            value:DatabaseService().ordersByUID(user.uid)
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
//          leading: IconButton(icon: Icon(Icons.close, color: Colors.black,size: 25, ),
//            onPressed: (){
//              Navigator.of(context)
//            },
//          ),
          actions: <Widget>[

          ],
          title: Text(
            'Orders', style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Colors.white
          ),
          ),
        ),
        body: ListView(
            children: <Widget>[
               OrderList()

            ],
        ),
      ),
    );
  }
}
