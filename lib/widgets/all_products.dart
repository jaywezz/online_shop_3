import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onlineshop3/app_screens/categories.dart';
import 'package:onlineshop3/app_screens/product_details_test.dart';
import 'package:onlineshop3/models/productsData.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget{
  final String category;

  const Products({Key key, this.category}) : super(key: key);
  @override
  _ProductsState createState() {

    return _ProductsState();
  }
}

class _ProductsState extends State<Products>{

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<ProductsData>>(context) ?? [];

    print(products.length);


    return GridView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index){
          print(index);
          return SingleProduct(
            product_id: products[index].producsId,
            product_name: products[index].productName,
            product_picture: products[index].images,
            product_description: products[index].productDescription,
            product_category: products[index].producsCategory,
            product_price: products[index].productPrice,
            product_rating: products[index].productRating,
            product_available: products[index].productsAvailable,

          );

        }
    );
  }
}



class SingleProduct extends StatelessWidget{
  final String product_id;
  final String product_name;
  final double product_price;
  final List product_picture;
  final String product_description;
  final String product_category;
  final int product_rating;
  final int product_available;



  const SingleProduct({Key key, this.product_name,this.product_id,this.product_available, this.product_price, this.product_picture, this.product_description, this.product_category, this.product_rating}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 180,
        height:300,
        child: Stack(
            children: <Widget>[
              Container(

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
                  Container(
                      height:90,
                      decoration: BoxDecoration(
                        color: Colors.red,

                      ),
                      child: InkWell(

                          onTap: (){
                            print('presses inkwell');
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => ProductDetailsTest(
                                  product_id:product_id,
                                  product_name: product_name,
                                  product_price: product_price,
                                  product_picture: product_picture,
                                  product_rating: product_rating,
                                  product_category: product_category,
                                  product_description: product_description,
                                  product_available: product_available,

                                ))
                            );
                          },
                          child: Image.network(product_picture[0],fit: BoxFit.cover,height: 90, filterQuality: FilterQuality.low,))),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(product_name,
                              style: TextStyle(
                                  fontSize: 13
                              ),),
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Ksh. ${product_price.toString()}", style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.redAccent
                            ),),
                          ),

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
                                        .collection('cart').where("id", isEqualTo: product_id);
                                    cart_product.getDocuments().then((snaps) {
                                      final Query items_on_my_cart = cart_product.where('user_id', isEqualTo: user.uid);
                                      items_on_my_cart.getDocuments().then((snaps2){
                                        print('snaps.documents.length');
                                        if(snaps2.documents.length > 0) {
                                          Fluttertoast.showToast(msg: 'Already on cart', textColor: Colors.deepOrange);


                                        } else{
                                          try{
                                            DatabaseService().AddToCart(
                                              product_id,
                                              product_name,
                                              product_picture[0],
                                              product_category,
                                              product_price,
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
      ),
    );
//    return Card(
//
//      child: Hero(
//        tag: product_picture,
//        child: Material(
//          child: InkWell(
//
//            child: InkWell(
//              onTap: () => Navigator.of(context).push(
//                  MaterialPageRoute(builder: (context) => ProductDetailsTest(
//                    product_id:product_id,
//                    product_name: product_name,
//                    product_price: product_price,
//                    product_picture: product_picture,
//                    product_rating: product_rating,
//                    product_category: product_category,
//                    product_description: product_description,
//                    product_available: product_available,
//
//
//                  ))
//              ),
//              child:Image.network(product_picture[0],filterQuality: FilterQuality.low,
//                fit: BoxFit.cover,)
//            ),
//
//          ),
//        ),
//      ),
//    );

  }

}