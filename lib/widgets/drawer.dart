import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:onlineshop3/app_screens/categories.dart';
import 'package:onlineshop3/app_screens/category_list.dart';
import 'package:onlineshop3/app_screens/foods_screen.dart';
import 'package:onlineshop3/app_screens/home_screen2.dart';
import 'package:onlineshop3/app_screens/orders.dart';
import 'package:onlineshop3/app_screens/settings_screen.dart';
import 'package:onlineshop3/models/categoriesData.dart';
import 'package:onlineshop3/models/orderData.dart';
import 'package:onlineshop3/models/subCategories.dart';
import 'package:onlineshop3/models/userData.dart';
import 'package:onlineshop3/services/auth.dart';
import 'package:onlineshop3/widgets/bottom_navigation2.dart';
import 'package:onlineshop3/wrapper.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {

  final String user_name;
  final String user_email;
  final String user_avatar;

  const AppDrawer({Key key, this.user_name, this.user_email, this.user_avatar}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user_data = Provider.of<List<UserData>>(context) ?? [];
    final categories = Provider.of<List<CategoriesData>>(context) ?? [];

    final orders = Provider.of<List<OrderData>>(context) ?? [];

//    print('cjzhvcjhzcvjh');
//       print(subcategories.length);
//    print('cjzhvcjhzcvjh');
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(

        child: ListView(
          children: <Widget>[
            SizedBox(height: 30,),
            Container(
              height: 90,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Colors.orange, Colors.deepOrange])),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/b2.jpg'),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
           user_data[0].names,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600),
            ),
            Text(
             user_data[0].email,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
            SizedBox(height: 30.0),

            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Wrapper()));

              },
              child: ListTile(
                title: Text("Home Page"),
                leading: Icon(Icons.home,  color: Colors.red),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllOrders()));
              },
              child: ListTile(
                title: Text("My Orders"),
                leading: Icon(Icons.shopping_basket,  color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('Categories', style: TextStyle(fontSize: 12),),
            ),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (context, index){
                      return Column(
                        children: <Widget>[
                          InkWell(
                            onTap: (){


                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Categories(category: categories[index].categoryName,)));


                              },
                            child: ListTile(
                              title: Text(categories[index].categoryName),
                              trailing: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios,
                                    color: Colors.redAccent,),
                                  onPressed: (){}

                              ),
                            ),
                          ),

                        ],
                      );
                    }
                ),
              ),
            ),

//          InkWell(
//            onTap: (){},
//            child: ListTile(
//
//              title: Text("Favourites"),
//              leading: Icon(Icons.favorite, color: Colors.red,),
//            ),
//          ),
//
          Divider(),
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettingsThreePage()));

            },
            child: ListTile(
              title: Text("Settings"),
              leading: Icon(Icons.settings,  color: Colors.blueAccent),
            ),
          ),
//          InkWell(
//            onTap: (){},
//            child: ListTile(
//              title: Text("About"),
//              leading: Icon(Icons.help,  color: Colors.deepOrangeAccent),
//            ),
//          ),
//          Divider(),
            InkWell(
              onTap: () async{
                await _auth.signOut();
              },
              child: ListTile(
                title: Text("Log Out"),
                leading: Icon(Icons.person_outline,  color: Colors.deepOrangeAccent),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
