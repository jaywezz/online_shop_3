import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop3/models/cartData.dart';
import 'package:onlineshop3/models/productsData.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/utils/CustomTextStyle.dart';
import 'package:onlineshop3/utils/CustomUtils.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  final String product_id;
  final String product_name;
  final int quantity;
  final double price;
  final String image;
  final String category;

  const CartItem({Key key, this.product_id, this.category, this.product_name, this.quantity, this.price, this.image}) : super(key: key);



  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
   int quantity;
    print('ddddh');

//    final Stream<QuerySnapshot> cartProducts = Firestore.instance.collection('products').where("id", isEqualTo: widget.product_id).snapshots();
//    cartProducts.forEach((element) {
//      print(element.documents);
//    });

    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    color: Colors.white,
                ),
                child: Image.network(widget.image),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          widget.product_name,
                          maxLines: 2,
                          softWrap: true,
                          style: CustomTextStyle.textFormFieldSemiBold
                              .copyWith(fontSize: 14),
                        ),
                      ),
                      Utils.getSizedBox(height: 6),
                      Text(
                        "Green M",
                        style: CustomTextStyle.textFormFieldRegular
                            .copyWith(color: Colors.grey, fontSize: 14),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                             widget.price.toString(),
                              style: CustomTextStyle.textFormFieldBlack
                                  .copyWith(color: Colors.deepOrange),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      size: 24,
                                      color: Colors.grey.shade700,
                                    ),
                                    onPressed: (){
                                      if(widget.quantity > 0){
                                        final Query cart_product = Firestore.instance
                                            .collection('cart').where("id", isEqualTo: widget.product_id);
                                        cart_product.getDocuments().then((snaps) {
                                          final String id_doc = snaps.documents[0].documentID;
                                          print(id_doc);
                                          try{
                                            Firestore.instance.collection("cart").document(id_doc).updateData({
                                              "quantity": widget.quantity - 1,

                                            });
                                          }catch(e){
                                            print(e.toString());
                                          }

                                        });
                                      }else{

                                      }

                                    },
                                  ),
                                  Container(
                                    color: Colors.grey.shade200,
                                    padding: const EdgeInsets.only(
                                        bottom: 2, right: 12, left: 12),
                                    child: Text(
                                       widget.quantity.toString(),
                                      style:
                                      CustomTextStyle.textFormFieldSemiBold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      size: 24,
                                      color: Colors.grey.shade700,
                                    ),
                                    onPressed: () async {
                                      final Query cart_product = Firestore.instance
                                          .collection('cart').where("id", isEqualTo: widget.product_id);
                                      cart_product.getDocuments().then((snaps) {
                                        final String id_doc = snaps.documents[0].documentID;
                                        print(id_doc);
                                        try{
                                          Firestore.instance.collection("cart").document(id_doc).updateData({
                                            "quantity": widget.quantity + 1,

                                          });
                                        }catch(e){
                                          print(e.toString());
                                        }

                                      });

                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.deepOrangeAccent,
              size: 25,
            ),
            onPressed: () async{
              final Query cart_product = Firestore.instance
                  .collection('cart').where("id", isEqualTo: widget.product_id);

              cart_product.getDocuments().then((snaps) {
                final String id_doc = snaps.documents[0].documentID;
                print(id_doc);
                try{
                  Firestore.instance.collection("cart").document(id_doc).delete();
                  print('delete succes');
                }catch(e){
                  print(e.toString());
                }

              });

            },
          ),
        )
      ],
    );
  }
}
