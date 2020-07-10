import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:onlineshop3/models/cartData.dart';
import 'package:onlineshop3/models/productsData.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/widgets/bottom_navigation.dart';
import 'package:onlineshop3/widgets/menu_dashboard.dart';
import 'package:onlineshop3/widgets/similar_products.dart';
import 'package:provider/provider.dart';

import 'categories.dart';

class ProductDetailsTest extends StatefulWidget{
  final String product_id;
  final String product_name;
  final double product_price;
  final List product_picture;
  final String product_description;
  final String product_category;
  final int product_rating;
  final int product_available;

  const ProductDetailsTest({Key key,this.product_id, this.product_available, this.product_name, this.product_price, this.product_picture, this.product_description, this.product_category, this.product_rating}) : super(key: key);


  _ProductDetailsState createState() {

    return  _ProductDetailsState();
  }
}

class _ProductDetailsState extends State<ProductDetailsTest>{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context) ;

    bool cart_loading = false;
    return MultiProvider(
      providers: [
        StreamProvider<List<ProductsData>>.value(
          value:DatabaseService().productsByCategory(widget.product_category),),
      ],
      child: Scaffold(
        key: _scaffoldKey,
          appBar:AppBar(
            backgroundColor: Colors.deepOrange,
            elevation: 0,
            actions: <Widget>[
              TopBarIcons(context)
      ]
      ),

        body: Container(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[

                   Column(
                     children: <Widget>[
                       Container(
                        height: 250,

                        child: Carousel(
                              boxFit: BoxFit.cover,

                              images: [
                                 Image.network(widget.product_picture[0],
                                   fit: BoxFit.cover,),
                                Image.network(widget.product_picture[2],
                                   fit: BoxFit.cover,),
                                Image.network(widget.product_picture[2],
                                  fit: BoxFit.cover,),


                              ],
                              autoplay: true,
                              animationCurve: Curves.fastOutSlowIn,
                              animationDuration: Duration(milliseconds: 1000),
                              dotSize: 4.0,


                              ),
                       ),

                     ],

                   ),

                ],
              ),
              Container(
                decoration: BoxDecoration(

                ),
                height: 180,
                padding: EdgeInsets.all(20),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(widget.product_name, style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      letterSpacing: 0,
                      fontSize: 18,
                    ),),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(" Category: ", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              letterSpacing: 0,
                              fontSize: 14,
                            ),),
                            Text(widget.product_category.toString(), style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              letterSpacing: 0,
                              fontSize: 13,
                            ),),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Available : ", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              letterSpacing: 0,
                              fontSize: 14,
                            ),),
                            Text(widget.product_available.toString(), style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.redAccent,
                              letterSpacing: 0,
                              fontSize: 14,
                            ),),
                          ],
                        ),


                      ],
                    ),


                    SizedBox(height: 10,),
                    Text("\$2,020", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      letterSpacing: 1,
                      fontSize: 15,
                    ),),
                    SizedBox(height: 10,),
                    Text("Ksh.${widget.product_price.toString()}", style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                      letterSpacing: 1,
                      fontSize: 19,
                    ),),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(Icons.star, size: 20, color: Colors.orangeAccent),
                        Icon(Icons.star, size: 20, color: Colors.orangeAccent),
                        Icon(Icons.star, size: 20, color: Colors.orangeAccent),
                        Icon(Icons.star, size: 20, color: Colors.orangeAccent),
                        Icon(Icons.star, size: 20, color: Colors.orangeAccent),
                        Text("(56)", style: TextStyle(
                            color: Colors.black,
                            fontSize: 15
                        ),),
                        Text("Reviews", style: TextStyle(
                            color: Colors.black,
                            fontSize: 16
                        ),),
                      ],
                    ),
                  ],
                ),

              ),

              SizedBox(height: 0,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text("Product Details", style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                      letterSpacing: 1,
                      fontSize: 18,
                    ),),
                    SizedBox(height: 20,),
                    Text("1) MackBook Pro", style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black54,
                      letterSpacing: 1,
                      fontSize: 15,
                    ),),
                    SizedBox(height: 15,),
                    Text("2) Ram 8Gb DDR4", style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black54,
                      letterSpacing: 1,
                      fontSize: 15,
                    ),),
                    SizedBox(height: 15,),
                    Text("2) SSD 256 GB", style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black54,
                      letterSpacing: 1,
                      fontSize: 15,
                    ),),
                    SizedBox(height: 15,),

                    Text("4) No Touch bar", style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black54,
                      letterSpacing: 1,
                      fontSize: 15,
                    ),),
                  ],
                ),
              ),
              SizedBox(height: 11,),

                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Text(
                         "Description",style: TextStyle(
                     fontWeight: FontWeight.w600,
                         color: Colors.black54,
                     letterSpacing: 1,
                     fontSize: 20,)
                       ),
                       SizedBox(height: 20,),
                       Text(widget.product_description, style: TextStyle(
                         fontWeight: FontWeight.w300,
                         color: Colors.black,
                         wordSpacing: 1,
                         fontSize: 15,
                       ),),
                     ],
                   ),
                 ),
              SizedBox(height: 10,),

              Text(
                  "Returns And Delivery",style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
                letterSpacing: 1,
                fontSize: 20,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 60,
                          height: 60,
                          child: Icon(Icons.tram, size: 29,color: Colors.red,)),
                        Padding(
                          padding: const EdgeInsets.all(.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Delivery Information",style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    letterSpacing: 0,
                                    fontSize: 16,),
                                  ),
                                  SizedBox(width: 60,),
                                  Icon(Icons.send, color: Colors.red,)
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Usually delivered in Nyahururu town\nbetween a span of 3 days, Please Ceck the\n exact dates in the checkou page ", style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  fontSize: 13,
                                ),),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: 60,
                          height: 60,
                          child: Icon(Icons.keyboard_return, size: 29,color: Colors.red,)),
                      Padding(
                        padding: const EdgeInsets.all(.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Return Policy",style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              letterSpacing: 0,
                              fontSize: 16,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('15 days feee return', style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black,

                                fontSize: 15,
                              ),),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),

                child: Text("Similar Items", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: 1,
                            fontSize: 15,)),
              ),




              SizedBox(height: 0,),
              //Similar products

              SimilarProducts(
                product_category: widget.product_category,
              )
            ],

          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            setState(() {
              cart_loading = true;
            });
            final Query cart_product = Firestore.instance
                .collection('cart').where("id", isEqualTo: widget.product_id);
            cart_product.getDocuments().then((snaps) {
                 final Query items_on_my_cart = cart_product.where('user_id', isEqualTo: user.uid);
                 items_on_my_cart.getDocuments().then((snaps2){
                   print('snaps.documents.length');
                  if(snaps2.documents.length > 0) {
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
                                Text('Already on cart',style: TextStyle(
                                    color: Colors.white
                                ),),
                              ],
                            )
                        )
                    );
                  });


                } else{
                    try{
                      DatabaseService().AddToCart(
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
                  }
                 });

            });

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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }



}