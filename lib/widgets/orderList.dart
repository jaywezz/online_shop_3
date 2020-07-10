import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop3/app_screens/init_payment.dart';
import 'package:onlineshop3/models/orderData.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    final orders= Provider.of<List<OrderData>>(context) ?? [];
    print(orders.length);
    print('orders.length');
    if(orders.length == 0){
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Center(child: Text('You have made no orders', style: TextStyle(
          color: Colors.black
        ),)),
      );
    }else{
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(20),
            color: Colors.white60,
          ),

          child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: orders.length,
              itemBuilder: (context, index){
                if(orders[index].order_status == 'Cancelled'){
                  return InkWell(
                    onTap: (){
                      print('tapped order');
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => InitPayment(orderId: orders[index].order_id,)));
                    },
                    child: ListTile(
                      trailing: IconButton(icon: Icon(Icons.delete),
                      onPressed: () async{
                        final Query order = Firestore.instance
                            .collection('orders').where("order_id", isEqualTo: orders[index].order_id);

                        order.getDocuments().then((snaps) {
                          final String id_doc = snaps.documents[0].documentID;
                          print(id_doc);
                          try{
                            Firestore.instance.collection("orders").document(id_doc).delete();
                            print('Delete succes');

                          }catch(e){
                            print(e.toString());
                          }

                        });
                      },
                      ),
                      title: Text(orders[index].order_id, ),

                      subtitle: Text("Order Status: ${orders[index].order_status }", style: TextStyle(
                          color: Colors.red
                      ),),
                    ),
                  );
                }
                return InkWell(
                  onTap: (){
                    print('tapped order');
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => InitPayment(orderId: orders[index].order_id,)));
                  },
                  child: ListTile(
                    trailing: IconButton(icon: Icon(Icons.delete, color: Colors.red,size: 20,),
                      onPressed: () async{
                        final Query order = Firestore.instance
                            .collection('orders').where("order_id", isEqualTo: orders[index].order_id);

                        order.getDocuments().then((snaps) {
                          final String id_doc = snaps.documents[0].documentID;
                          print(id_doc);
                          try{
                            Firestore.instance.collection("orders").document(id_doc).delete();
                            print('Cancel succes');

                          }catch(e){
                            print(e.toString());
                          }

                        });
                      },
                    ),
                    title: Text(orders[index].order_id, ),

                    subtitle: Text("Order Status: ${orders[index].order_status }", style: TextStyle(
                      color: Colors.green
                    ),),
                  ),
                );
              }
          ),
        ),
      );
    }
  }
}
