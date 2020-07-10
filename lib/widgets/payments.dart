import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop3/app_screens/cart.dart';
import 'package:onlineshop3/models/cartData.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/utils/CustomTextStyle.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String groupalue = "M-pesa";
  String payment_method = '';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final cart= Provider.of<List<CartData>>(context) ?? [];
    double total = 0;
    double vat = 3.5;
    double shippment_fee = 200.0;
    setState(() {
      cart.forEach((item) {
       print( item.price);
        total = total + (item.price * item.quantity);
      });
    });
    return Container(
      child: ListView(
        shrinkWrap: true,
        primary: true,
        physics: ScrollPhysics(),
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white

                ),

                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),

                    shrinkWrap: true,
                     itemCount: cart.length,
                    itemBuilder: (context, index){

                       return Padding(
                         padding: const EdgeInsets.only(left:18.0, top:15, bottom: 5),
                         child: Row(
                           children: <Widget>[
                             Text(cart[index].quantity.toString()),
                             SizedBox(width: 10,),
                             Text(cart[index].productame),
                             SizedBox(width: 120,),
                             Text(cart[index].price.toString()),
                           ],
                         ),
                       );
                    }
                ),

              ),
              OutlineButton(

                splashColor: Colors.grey,
                onPressed: ()  {
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage()));
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                highlightElevation: 0,
                borderSide: BorderSide(color: Colors.grey),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.shopping_cart),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Edit Your Cart',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left:15.0, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(' Sub Total:',style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),),
                            ),
                            Text("Ksh.${total.toString()}",style: TextStyle(
                                fontSize: 15
                            ),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(' VAT:',style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            Text("ksh. ${vat}",style: TextStyle(
                                fontSize: 20
                            ),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(' Shippment Fee:',style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            Text("ksh. ${shippment_fee}",style: TextStyle(
                                fontSize: 20
                            ),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(' TOTAL:',style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            Text("ksh. ${shippment_fee + total + vat}",style: TextStyle(
                                fontSize: 20
                            ),),
                          ],
                        ),
                      ],

                    ),
                  ),

                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Payment method",style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  letterSpacing: 0,
                  fontSize: 19,),
                ),
                SizedBox(width: 60,),
                Icon(Icons.attach_money, color: Colors.red,),

              ],
            ),

          ),
          ListTile(
              leading: Image.asset('assets/images/mpesa.png', width:70),
              title:Text(
                "M-pesa",
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.black),),
              trailing:Radio(
                value: "M-pesa",
                  groupValue: groupalue,
                  activeColor: Colors.green,
                  onChanged: (e) => valueChanged(e, user.uid)

              )),
          ListTile(
            leading: Image.asset('assets/images/pesapal2.png', width:100),
              title:Text(
                "PesaPal",
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.black),),
              trailing:Radio(
                value: "PesaPal",
                  activeColor: Colors.deepOrange,

                  groupValue: groupalue,
                  onChanged: (e) => valueChanged(e, user.uid)
              )),
        ],
      ),
    );
  }

  valueChanged(e, String user) {

    setState(() {
      if(e == "PesaPal"){
        final Query cart_product = Firestore.instance
            .collection('users').where("user_id", isEqualTo: user);
        cart_product.getDocuments().then((snaps) {
          final String id_doc = snaps.documents[0].documentID;
          print(id_doc);
          try{
            Firestore.instance.collection("users").document(id_doc).updateData({
              'payment_method' : e
            });

            print('Updated payment method to ${e} where ${user}',);

          }catch(e){
            print('there was an error updating info');
            print(e.toString());
          }
        });
        print('Preffered payment method');
        print(e);
        groupalue = e;
        payment_method = e;

      }else if(e == "M-pesa"){
        final Query cart_product = Firestore.instance
            .collection('users').where("user_id", isEqualTo: user);
        cart_product.getDocuments().then((snaps) {
          final String id_doc = snaps.documents[0].documentID;
          print(id_doc);
          try{
            Firestore.instance.collection("users").document(id_doc).updateData({
              'payment_method' : e
            });


          print('Updated payment method to ${e} where ${user}',);
          }catch(e){
            print('there was an error updating info');
            print(e.toString());
          }

        });
        groupalue = e;
        print('Preffered payment method');
        print(e);
        payment_method = e;


      }
    });
  }
}
