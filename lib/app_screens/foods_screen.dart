import 'package:flutter/material.dart';
import 'package:onlineshop3/models/cartData.dart';
import 'package:onlineshop3/models/productsData.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/widgets/bottom_navigation.dart';
import 'package:onlineshop3/widgets/categories_widdget.dart';
import 'package:onlineshop3/widgets/food_product_widget.dart';
import 'package:onlineshop3/widgets/foods_appBar.dart';
import 'package:onlineshop3/widgets/random_generated_item.dart';
import 'package:provider/provider.dart';

class Foods extends StatefulWidget {
  @override
  _FoodsState createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<ProductsData>>.value(
          value:DatabaseService().productsByCategory('foods'),),
        StreamProvider<List<CartData>>.value(
            value: DatabaseService().cartProducts(user.uid))
      ],
      child: SafeArea(
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Padding(

                    padding: EdgeInsets.all(8.0),
                    child: Text("What would you like to eat?",style:
                      TextStyle(fontSize: 18),),
                  ),
                  Stack(
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.notifications_none), onPressed: null,),
                      Positioned(
                        top: 10,
                        right: 12,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: Colors.red, borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                      )
                    ],
                  )


                ],
              ),
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
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: "Find your favourite food",
                        border: InputBorder.none
                      ),
                    ),
                    trailing: Icon(Icons.filter_list, color: Colors.red,),
                  ),
                ),
              ),
              SizedBox(height: 5,),

//              CategoryWidget(),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Popular foods', style: TextStyle(
                  fontSize: 18, color: Colors.grey
                ),),
              ),

               Container(
                 height: 200,
                 child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                     itemCount: 4,
                     itemBuilder: (_, index){
                       return  Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Stack(
                           children: <Widget>[
                             Container(
                             width: 160,
                             height: 220,
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
                             ),
                             child: Column(
                               children: <Widget>[
                                 Container(
                                     decoration: BoxDecoration(
                                         color: Colors.white,
                                         shape: BoxShape.circle

                                     ),
                                     child: Image.asset('assets/images/food2.jpeg',width: 140, height: 120,)),
                                 SizedBox(height: 5,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: <Widget>[
                                     Padding(
                                       padding: const EdgeInsets.only(left:8.0),
                                       child: Text('Very fine food'),
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
                                           child: Icon(Icons.send, size: 16,color: Colors.red,)
                                         ))
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
               ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Best foods', style: TextStyle(
                    fontSize: 18, color: Colors.grey
                ),),
              ),
//              RandomFoodProduct(),

              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Enjoy our Tasty foods', style: TextStyle(
                    fontSize: 18, color: Colors.grey
                ),),
              ),
              FoodProduct()
            ],

          ),
        ),


    );
  }
}
