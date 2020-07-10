import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop3/app_screens/product_details_test.dart';
import 'package:onlineshop3/models/productsData.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:provider/provider.dart';

class SimilarProducts extends StatefulWidget {
  final String product_name;
  final double product_price;
  final List product_picture;
  final String product_description;
  final String product_category;
  final int product_rating;
  final int product_available;

  const SimilarProducts({Key key, this.product_name, this.product_price, this.product_picture, this.product_description, this.product_category, this.product_rating, this.product_available}) : super(key: key);
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context) ;
    final products = Provider.of<List<ProductsData>>(context) ?? [];
    print(products.length);
    return Container(
      height: 270,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (_, index){
            return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                  children: <Widget>[
                    Container(
                      width: 180,
                      height: 250,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.red[100],
                                offset: Offset(2,1),
                                blurRadius: 10
                            )
                          ]
                      ), child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => ProductDetailsTest(
                                    product_id: products[index].producsId,
                                    product_name: products[index].productName,
                                    product_price: products[index].productPrice,
                                   product_picture: products[index].images,
                                   product_rating:  products[index].productRating,
                                    product_category: products[index].producsCategory,
                                    product_description:  products[index].productDescription,
                                   product_available: products[index].productsAvailable,

                                  ))
                              );
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle

                                ),
                                child: Image.network(products[index].images[0],fit: BoxFit.cover,height: 120, filterQuality: FilterQuality.low,)),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(products[index].productName,
                                      style: TextStyle(
                                      fontSize: 13
                                    ),),
                                  ),
                                  SizedBox(height: 20,),
                                  Text("Ksh. ${products[index].productPrice.toString()}", style: TextStyle(
                                      fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.redAccent
                                  ),),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.star, size: 13, color: Colors.orangeAccent),
                                      Icon(Icons.star, size: 14, color: Colors.orangeAccent),
                                      Icon(Icons.star, size: 15, color: Colors.orangeAccent),
                                      Icon(Icons.star, size: 16, color: Colors.orangeAccent),
                                      Icon(Icons.star, size: 17, color: Colors.orangeAccent),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[200],
                                            offset: Offset(2,5),
                                            blurRadius: 7
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                          onTap: ()async{
                                            final Query cart_product = Firestore.instance
                                                .collection('cart').where("id", isEqualTo: products[index].producsId);
                                            cart_product.getDocuments().then((snaps) {
                                              final Query items_on_my_cart = cart_product.where('user_id', isEqualTo: user.uid);
                                              items_on_my_cart.getDocuments().then((snaps2){
                                                print('snaps.documents.length');
                                                if(snaps2.documents.length > 0) {
//                                    try{
//                                      final String id_doc = snaps2.documents[0].documentID;
//                                      items_on_my_cart.getDocuments().then((value) {
//                                        Firestore.instance.collection("cart").document(id_doc).updateData({
//                                          "quantity": widget.quantity + 1,
//
//                                        });
//                                      });
//                                    }catch(e){
//                                      print(e.toString());
//                                    }


                                                } else{
                                                  try{
                                                    DatabaseService().AddToCart(

                                                      products[index].producsId,
                                                      products[index].productName,
                                                      products[index].images[0],
                                                      products[index].producsCategory,
                                                      products[index].productPrice,
                                                      user.uid,
                                                      1,

                                                    );
                                                    print('added to cart');


                                                  }catch(e){
                                                    print('error adding to cart');
                                                    print(e.toString());
                                                  }
                                                }
                                              });

                                            });

                                          },
                                          child: Icon(Icons.shopping_cart, size: 16,color: Colors.red,))
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[200],
                                    offset: Offset(2,5),
                                    blurRadius: 7
                                )
                              ]
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.favorite, size: 16,color: Colors.red,)
                          )),
                    )

                  ]
              ),
            );
          }
      ),
    );
  }
}
