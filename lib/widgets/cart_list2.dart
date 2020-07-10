import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop3/models/cartData.dart';
import 'package:onlineshop3/models/productsData.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/utils/CustomTextStyle.dart';
import 'package:onlineshop3/utils/CustomUtils.dart';
import 'package:onlineshop3/widgets/cartItem.dart';
import 'package:provider/provider.dart';

class CartList2 extends StatefulWidget {
  @override
  _CartList2State createState() => _CartList2State();
}

class _CartList2State extends State<CartList2> {
  @override
  Widget build(BuildContext context) {
    final cart= Provider.of<List<CartData>>(context) ?? [];
    print(cart.length);


     if( cart.isNotEmpty){
       return Column(
         children: <Widget>[
       Container(
       alignment: Alignment.topLeft,
         child: Text(
           "Total (${cart.length}) Items",
           style: CustomTextStyle.textFormFieldBold
               .copyWith(fontSize: 12, color: Colors.grey),
         ),
         margin: EdgeInsets.only(left: 12, top: 4),
       ),
           Container(
               child:ListView.builder(
                   shrinkWrap: true,
                   primary: false,
                   itemCount: cart.length,
                   itemBuilder: (context, index) {
                     try{

                       return CartItem(product_id: cart[index].productId,
                         product_name: cart[index].productame,
                         price: cart[index].price,
                         image: cart[index].image,
                         quantity: cart[index].quantity,
                         category: cart[index].category,

                       );
                     }catch(e){
                       print('we have an errr ccsbelow');
                       print(e.toString());
                       return null;
                     }

                   }
               )
           ),
         ],
       );
     }else{
       return Container(
         height: MediaQuery.of(context).size.height - 20,
         color: Colors.transparent,
         child: Center(child: Text('No items on cart')),

       );
     }

  }
 
}
