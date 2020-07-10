import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onlineshop3/app_screens/categories.dart';
import 'package:onlineshop3/app_screens/product_details_test.dart';
import 'package:onlineshop3/models/cartData.dart';
import 'package:onlineshop3/models/categoriesData.dart';
import 'package:onlineshop3/models/orderData.dart';
import 'package:onlineshop3/models/productsData.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/models/userData.dart';
import 'package:onlineshop3/services/auth.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/widgets/all_products.dart';
import 'package:onlineshop3/widgets/bottom_navigation.dart';
import 'package:onlineshop3/widgets/drawer.dart';
import 'package:onlineshop3/widgets/menu_dashboard.dart';
import 'package:onlineshop3/widgets/products.dart';
import 'package:onlineshop3/widgets/recommended_products.dart';
import 'package:onlineshop3/widgets/topBarIcons.dart';
import 'package:onlineshop3/widgets/top_categories.dart';
import 'package:provider/provider.dart';

import 'foods_screen.dart';

class HomeScreen2 extends StatefulWidget {
  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  final ScrollController _mycontroller = new ScrollController();
  TextEditingController _typeAheadController = TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<User>(context);
    final products = Provider.of<List<ProductsData>>(context) ?? [];
    final categories = Provider.of<List<CategoriesData>>(context) ?? [];
    var rng = new Random();
    int featured_product = 0;
    print(featured_product);
    print('featured_product');


    return MultiProvider(
      providers: [
        StreamProvider<List<OrderData>>.value(
            value:DatabaseService().ordersByUID(user.uid)
        ),
        StreamProvider<List<UserData>>.value(
            value:DatabaseService().usersById(user.uid)
        ),

      ],



//        drawer: AppDrawer(),

        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
//        color: Colors.redAccent,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300],
                                offset: Offset(2,1),
                                blurRadius: 5
                            )
                          ]
                      ),
                      child: ListTile(
                        leading: Icon(Icons.search, color: Colors.red,),
                        title: Container(
                          height: 30,
                          child: TypeAheadField(

                            textFieldConfiguration: TextFieldConfiguration(
                              controller: _typeAheadController,
                              autofocus: false,

                              decoration: InputDecoration(

                                hintText: 'Search our store.. '
                              ),
                            ),
                            suggestionsCallback: (pattern) async{
                              return ;
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion),
                              );
                            },
                            transitionBuilder: (context, suggestionsBox, controller) {
                              return suggestionsBox;
                            },
                            onSuggestionSelected: (suggestion) {
                              this._typeAheadController.text = suggestion;
                            },


                          ),
                        ),
//                        title: TextField(
//                          decoration: InputDecoration(
//                              hintText: "Search our store.....",
//                              border: InputBorder.none
//                          ),
//                        ),
                        trailing: Icon(Icons.filter_list, color: Colors.red,),
                      ),
                    ),
                  ),
            Container(
              height: 120.0,
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: DiagonalPathClipperOne(),
                    child: Container(
                      height: 110,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Swiper(

                      itemWidth: 400,
                      duration: 300,
                      itemHeight: 100,
                      autoplayDisableOnInteraction: true,
                      autoplay: true,

                      itemBuilder: (BuildContext context, int index) {
                        return new Image.asset('assets/images/b2.jpg',fit: BoxFit.cover,);
                      },
                      itemCount: 4,
                      pagination: new SwiperPagination(),
                    ),
                  ),
                ],
              ),
            ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: Text("Menu", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                  TopCategories(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),

                    child: Text("Main Categories",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),),
                  ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                        itemBuilder: (_, index){
                          return makeCategory(image: categories[index].categoryImage, category: categories[index].categoryName, tag: categories[index].categoryName);
                        }
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(5.0),

                    child: Text("Recent",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RceentProducts(),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(5.0),

                    child: Text("Featured",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),),
                  ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      margin: EdgeInsets.only(bottom: 20.0),
                      height: 300,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => ProductDetailsTest(
                                        product_id:products[featured_product].producsId,
                                        product_name: products[featured_product].productName,
                                        product_price: products[featured_product].productPrice,
                                        product_picture: products[featured_product].images,
                                        product_rating: products[featured_product].productRating,
                                        product_category: products[featured_product].producsCategory,
                                        product_description: products[featured_product].productDescription,
                                        product_available: products[featured_product].productsAvailable,

                                      ))
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(products[0].images[featured_product]), fit: BoxFit.cover),
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(5.0, 5.0),
                                            blurRadius: 10.0)
                                      ]),
                                ),
                              )),

                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    products[0].productName,
                                    style:
                                    TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text( products[featured_product].producsCategory,
                                      style: TextStyle(color: Colors.grey, fontSize: 18.0)),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text( "ksh. ${products[featured_product].productPrice.toString()}",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16.0,
                                      )),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  InkWell(
                                    onTap: ()async{
                                      final Query cart_product = Firestore.instance
                                          .collection('cart').where("id", isEqualTo: products[featured_product].producsId);
                                      cart_product.getDocuments().then((snaps) {
                                        final Query items_on_my_cart = cart_product.where('user_id', isEqualTo: user.uid);
                                        items_on_my_cart.getDocuments().then((snaps2){
                                          print('snaps.documents.length');
                                          if(snaps2.documents.length > 0) {
                                            Fluttertoast.showToast(msg: 'Already on cart', textColor: Colors.deepOrange);

                                          } else{
                                            try{
                                              DatabaseService().AddToCart(
                                                products[featured_product].producsId,
                                                products[featured_product].productName,
                                                products[featured_product].images[0],
                                                products[featured_product].producsCategory,
                                                products[featured_product].productPrice,
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
                                    child: Container(
                                      height: 35,

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.deepOrange,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(

                                          children: <Widget>[
                                            Icon(Icons.shopping_cart, size: 17, color: Colors.white,),
                                            Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Text("Add to Cart", style: TextStyle(color: Colors.white),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(5.0, 5.0),
                                        blurRadius: 10.0)
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),

                    child: Text("Recommended for you",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RecommendedProducts(),
                  ),
                    Container(
                              height: 170,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: <Widget>[
                                  Image.asset('assets/images/advert.jpeg', width:  MediaQuery.of(context).size.width,),
                                  Positioned(
                                    left: 30,
                                    bottom: 10,
                                    child: Text('Shop, order and \nwe shall deliver',style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),),
                                  )
                                ],
                              ),
                            ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),

                    child: Text("All",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),),
                  ),

//
                  Products()


                ],
              )
            ],
          ),
        ),


//      floatingActionButton: FloatingActionButton(
//        onPressed: (){},
//        backgroundColor: Colors.redAccent,
//        child: InkWell(child: Icon(Icons.fastfood),
//            onTap: (){
//              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Foods()));}
//        ),
//      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//        bottomNavigationBar: BottomBar(),


    );
  }
  Widget makeCategory({image,category, tag}){
    return AspectRatio(
      aspectRatio: 2 / 2,
      child: Hero(
        tag: tag,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Categories(category: category,)));
          },
          child: Container(
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover
                )
            ),
            child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        colors: [
                          Colors.black.withOpacity(.8),
                          Colors.black.withOpacity(.0),
                        ]
                    )
                ),
                child:
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(category, style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),),
                )
            ),
          ),
        ),
      ),
    );
  }




}
