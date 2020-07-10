import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:provider/provider.dart';

class ProductDetailsFab extends StatefulWidget {
  final String product_id;
  final String product_name;
  final double product_price;
  final List product_picture;
  final String product_description;
  final String product_category;
  final int product_rating;
  final int product_available;

  const ProductDetailsFab({Key key, this.product_id, this.product_name, this.product_price, this.product_picture, this.product_description, this.product_category, this.product_rating, this.product_available}) : super(key: key);
  @override
  _ProductDetailsFabState createState() => _ProductDetailsFabState();
}

class _ProductDetailsFabState extends State<ProductDetailsFab> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    bool cart_loading = false;
    return FloatingActionButton(
      onPressed: () async {
        setState(() {
          cart_loading = true;
        });
        final Query cart_product = Firestore.instance
            .collection('cart').where("id", isEqualTo: widget.product_id);
        cart_product.getDocuments().then((snaps) {
          if(snaps.documents.length > 0) {
            final String id_doc = snaps.documents[0].documentID;
            print(snaps.documents[0].data[0]);

            try {
              Firestore.instance.collection("cart")
                  .document(id_doc)
                  .updateData({

              });
            } catch (e) {
              print(e.toString());
            }
          } });
        try{
          await DatabaseService().AddToCart(
            widget.product_id,
            widget.product_name,
            widget.product_picture[0],
            widget.product_category,
            widget.product_price.toDouble(),
            user.uid,
            1,

          );
          print('added to cart');
          setState(() {
            cart_loading = false;
            _scaffoldKey.currentState.showSnackBar(
                new SnackBar(
                    backgroundColor: Colors.green,
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.check, color: Colors.white,),
                        SizedBox(width: 10,),
                        Text('Added to cart succesfully',style: TextStyle(
                            color: Colors.white
                        ),),
                      ],
                    )
                )
            );
          });

        }catch(e){
          print('error adding to cart');
          print(e.toString());
        }
      },
      backgroundColor: Colors.deepOrange,
      child: cart_loading ? Container(
        color: Colors.deepOrange,
        child: Center(
          child: SpinKitRotatingCircle(
            color: Colors.white,
            size: 30.0,
          ),
        ),
      ):Icon(Icons.add_shopping_cart),
    );
  }
}
