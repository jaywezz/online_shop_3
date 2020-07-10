import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:onlineshop3/models/categoriesData.dart';
import 'package:onlineshop3/models/orderData.dart';
import 'package:onlineshop3/models/productsData.dart';
import 'package:onlineshop3/models/subCategories.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/models/userData.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/widgets/all_products.dart';
import 'package:onlineshop3/widgets/bottom_navigation.dart';
import 'package:onlineshop3/widgets/drawer.dart';
import 'package:onlineshop3/widgets/menu_dashboard.dart';
import 'package:onlineshop3/widgets/products.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget{

  final String category;


  Categories({Key key, this.category}) : super(key: key);
  @override
  _CategoryState createState() {

    return _CategoryState();
  }

}

class _CategoryState extends State<Categories>
    with SingleTickerProviderStateMixin {

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return MultiProvider(
      providers: [
        StreamProvider<List<CategoriesData>>.value(
            value: DatabaseService().categoriesList),
        StreamProvider<List<UserData>>.value(
            value:DatabaseService().usersById(user.uid)
        ),

        StreamProvider<List<ProductsData>>.value(
            value: DatabaseService().productsByCategory(widget.category)),

        StreamProvider<List<SubCategoryData>>.value(
            value:DatabaseService().subcategories(widget.category)),
        StreamProvider<List<OrderData>>.value(
            value:DatabaseService().ordersByUID(user.uid),
        ),



//        StreamProvider<List<SubCategoryData>>.value(
//            value: DatabaseService().subcategories('foods')),
      ],
      child: Scaffold(

        appBar:AppBar(
            backgroundColor: Colors.deepOrange,
            elevation: 0,
            actions: <Widget>[
              TopBarIcons(context)
            ],
          title: Text(
              widget.category, style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
            color: Colors.white
          ),
          ),
        ),


        drawer:  AppDrawer(),
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: 0),
          children: [
            SizedBox(height: 5,
            ),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.redAccent,
              isScrollable: true,
              labelColor: Colors.redAccent,
              labelPadding: EdgeInsets.only(right: 45),
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  child: Text(
                    "Cookies",
                    style: TextStyle(fontFamily: 'Varela',
                        fontSize: 19),
                  ),
                ),
                Tab(
                  child: Text(
                    "Cakes",
                    style: TextStyle(fontFamily: 'Varela',
                        fontSize: 19),
                  ),
                ),
                Tab(
                  child: Text(
                    "Ice Cream",
                    style: TextStyle(fontFamily: 'Varela',
                        fontSize: 19),
                  ),
                ),
                Tab(
                  child: Text(
                    "Cookie Cake",
                    style: TextStyle(fontFamily: 'Varela',
                        fontSize: 19),
                  ),
                )
              ],
            ),
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
                        hintText: "Search for ${widget.category}....",
                        border: InputBorder.none
                    ),
                  ),
                  trailing: Icon(Icons.filter_list, color: Colors.red,),
                ),
              ),
            ),
            Container(
              height: 500,
              width: double.infinity,
              child: TabBarView(

                  controller: _tabController,
                  children: [
                    //sub category 1
                     Products(),
                    //sub category 1
                     Products(),
                    //sub category 1
                     Products(),
                    //sub category 1
                     Products(),
                  ]
              ),

            )

          ],
        ),

      ),
    );
  }

}