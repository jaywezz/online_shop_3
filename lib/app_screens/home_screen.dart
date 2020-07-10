import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop3/app_screens/foods_screen.dart';
import 'package:onlineshop3/models/categoriesData.dart';
import 'package:onlineshop3/models/productsData.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/services/auth.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/widgets/bottom_navigation.dart';
import 'package:onlineshop3/widgets/drawer.dart';
import 'package:onlineshop3/widgets/icons_container.dart';
import 'package:onlineshop3/widgets/menu_dashboard.dart';
import 'package:onlineshop3/widgets/products.dart';
import 'package:onlineshop3/widgets/top_categories.dart';
import 'package:provider/provider.dart';

import 'categories.dart';




class HomeTest extends StatefulWidget {
  @override
  _HomeTest createState() {
    return _HomeTest();
  }
}
class _HomeTest extends State<HomeTest>{
  final ScrollController _mycontroller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    



    return MultiProvider(
      providers: [
        StreamProvider<List<ProductsData>>.value(
            value:DatabaseService().products,),

        StreamProvider<List<CategoriesData>>.value(
            value: DatabaseService().categoriesList)
      ],
      child:Padding(
          padding: const EdgeInsets.all(0),
          child: Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.deepOrange,
                  elevation: 0,
                  actions: <Widget>[
                    TopBarIcons(context)
                  ]
              ),

              drawer: AppDrawer(),

              body: Container(
                height: 1700,
                child: ListView(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Column(
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
                                    title: TextField(
                                      decoration: InputDecoration(
                                          hintText: "Search our store.....",
                                          border: InputBorder.none
                                      ),
                                    ),
                                    trailing: Icon(Icons.filter_list, color: Colors.red,),
                                  ),
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
                                padding: const EdgeInsets.all(5.0),

                                child: Text("Best Selling",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600
                                  ),),
                              ),
                              ListView.builder(
                                  itemBuilder: (_, index){
                                    return Container(
                                      height: 150,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: <Widget>[
                                          makeCategory(image: 'assets/images/home_2.jpg', category: 'Sweaters', tag: 'Beauty'),




                                        ],
                                      ),
                                    );
                                  }
                              ),



                              Container(

                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 300,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
                                          image: DecorationImage(
                                              image: AssetImage('assets/images/box_1_img.jpg'),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(0),
                                            gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.black.withOpacity(.6),
                                                  Colors.black.withOpacity(.1)
                                                ]
                                            )
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text("Best Child Sale", style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 25
                                            ),),
                                            SizedBox(height: 30,),
                                            Container(
                                              width: 200,
                                              height: 50,
                                              margin: EdgeInsets.only(bottom: 30),

                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  color: Colors.deepOrange
                                              ),
                                              child: FlatButton(
                                                child: Text("Buy Now",  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20
                                                ),),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              RceentProducts()





                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

            floatingActionButton: FloatingActionButton(
              onPressed: (){},
              backgroundColor: Colors.redAccent,
              child: InkWell(child: Icon(Icons.fastfood),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Foods()));}
               ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomBar(),
          )),
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
                    image: AssetImage(image),
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

