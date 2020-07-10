import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:onlineshop3/app_screens/home_screen.dart';
import 'package:onlineshop3/app_screens/home_screen2.dart';
import 'package:onlineshop3/app_screens/orders.dart';
import 'package:onlineshop3/models/orderData.dart';
import 'package:onlineshop3/models/orderDetailsData.dart';
import 'package:onlineshop3/models/userData.dart';
import 'package:onlineshop3/widgets/cartItem.dart';
import 'package:provider/provider.dart';

class OrdersBottomBar extends StatefulWidget{
  @override
  _OrdersBottomBarState createState() => _OrdersBottomBarState();
}

class _OrdersBottomBarState extends State<OrdersBottomBar> {
  @override
  Widget build(BuildContext context) {
    final order_details_data= Provider.of<List<OrderDetailsData>>(context) ?? [];
    final order_data= Provider.of<List<OrderData>>(context) ?? [];
    final user_data= Provider.of<List<UserData>>(context) ?? [];
    double total = 0;
    double vat = 3.5;
    double shippment_fee = 200.0;
    setState(() {
      order_details_data.forEach((item) {
        print( item.price);
        total = shippment_fee + vat +  total + (item.price * item.quantity);
      });
    });
    // TODO: implement build
    return BottomAppBar(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left:30.0,bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 20),
                height: 50,
                width: 100,
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.transparent

                ),
                child: Center(
                  child: InkWell(
                    onTap: (){
                      final Query order = Firestore.instance
                          .collection('orders').where("order_id", isEqualTo: order_data[0].order_id);

                      order.getDocuments().then((snaps) {
                        final String id_doc = snaps.documents[0].documentID;
                        print(id_doc);
                        try{
                          Firestore.instance.collection("orders").document(id_doc).updateData(
                            {'order_status' : 'Cancelled'}
                          );
                          print('Cancel succes');
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AllOrders()));
                        }catch(e){
                          print(e.toString());
                        }

                      });
                    },
                    child: Text("Cancel Order", style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                    ),),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 40),
                height: 50,
                width: 100,
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.green

                ),
                child: Center(
                  child: InkWell(
                    onTap: ()async{
                      print('initiating payment');
                      dynamic mpesatransactionInitialisation;
                      try {
                        //Run it
                        mpesatransactionInitialisation =
                        await MpesaFlutterPlugin.initializeMpesaSTKPush(
                            businessShortCode: '174379',
                            transactionType: TransactionType.CustomerPayBillOnline,
                            amount: double.parse(total.toString()),
                            partyA: user_data[0].phone_number,
                            partyB: '174379',
                            callBackURL: Uri.parse("https://sandbox.safaricom.co.ke/"),
                            accountReference:'Pay for your order',
                            phoneNumber: user_data[0].phone_number,
                            baseUri: Uri.parse("https://sandbox.safaricom.co.ke/"),
                            transactionDesc:'Payment for goods',

                            passKey:'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');
                        print("Transaction Result:"+ mpesatransactionInitialisation.toString());
                       print('payment succes');
                        return mpesatransactionInitialisation;
                      } catch (e) {
                        //you can implement your exception handling here.
                        //Network unreachability is a sure exception.
                        print('we had an errrorin mpesa payments');
                        print(e.getMessage());

                      }
                     },
                    child: Text("Pay", style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    ),),
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}