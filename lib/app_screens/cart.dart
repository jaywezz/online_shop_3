import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop3/models/cartData.dart';
import 'package:onlineshop3/models/productsData.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/utils/CustomTextStyle.dart';
import 'package:onlineshop3/widgets/cart_list2.dart';
import 'package:onlineshop3/widgets/cartottomNav.dart';
import 'package:provider/provider.dart';


class CartPage extends StatefulWidget {


  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    final Query cart_product = Firestore.instance
        .collection('cart').where("user_id", isEqualTo: user.uid);
    return MultiProvider(
      providers: [

        StreamProvider<List<CartData>>.value(
          value:DatabaseService().cartProducts(user.uid)
        ),


//        StreamProvider<List<ProductsData>>.value(
//
//            value:DatabaseService().productsById(produtId)
//        )
      ],
      child: Scaffold(

        backgroundColor: Colors.grey.shade100,

        appBar: AppBar(
          elevation: 0.1,

          backgroundColor: Colors.white,
          title: Text('Shopping Cart', style: TextStyle(color: Colors.black),),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.delete_sweep, size: 30,color: Colors.deepOrangeAccent,),
              onPressed: ()async{
                print('djdjd');
                cart_product.getDocuments().then((value){
                  value.documents.forEach((element) {
                    print(element.documentID);
                    Firestore.instance.collection("cart").document(element.documentID).delete();
                  });
                });
            },),
          ],
        ),
        body: ListView(
              children: <Widget>[


                CartList2()

              ],
            ),

        bottomNavigationBar: CartBottomBar(),

      ),
    );
  }




  createSubTitle() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Total (3) Items",
        style: CustomTextStyle.textFormFieldBold
            .copyWith(fontSize: 12, color: Colors.grey),
      ),
      margin: EdgeInsets.only(left: 12, top: 4),
    );
  }




}