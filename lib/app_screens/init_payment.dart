import 'package:flutter/material.dart';
import 'package:onlineshop3/models/orderData.dart';
import 'package:onlineshop3/models/orderDetailsData.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/models/userData.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/widgets/order_details_widget.dart';
import 'package:onlineshop3/widgets/orders_bottom_nav.dart';
import 'package:provider/provider.dart';

class InitPayment extends StatefulWidget {
  final String orderId;

  const InitPayment({Key key, this.orderId}) : super(key: key);
  @override
  _InitPaymentState createState() => _InitPaymentState();
}

class _InitPaymentState extends State<InitPayment> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return MultiProvider(
      providers: [

        StreamProvider<List<OrderData>>.value(
          value:DatabaseService().ordersByOID(widget.orderId)
        ),
        StreamProvider<List<UserData>>.value(
            value:DatabaseService().usersById(user.uid)
        ),

        StreamProvider<List<OrderDetailsData>>.value(
            value:DatabaseService().ordersDetails(widget.orderId)
        ),

      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          actions: <Widget>[

          ],
          title: Text(
            'Order Details', style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Colors.white
          ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Thanyou for placing your order,we will process your order after making full payments, for the following',
                    style: TextStyle(
                      fontSize:16
                    ),),
                  ),
                  OrderDetailsWidget()
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: OrdersBottomBar(),
      ),
    );
  }
}
