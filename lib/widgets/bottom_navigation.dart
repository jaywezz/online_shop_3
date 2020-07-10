import 'package:flutter/material.dart';
import 'package:onlineshop3/app_screens/cart.dart';
import 'package:onlineshop3/app_screens/category_list.dart';
import 'package:onlineshop3/app_screens/foods_screen.dart';
import 'package:onlineshop3/app_screens/settings_screen.dart';
import 'package:onlineshop3/app_screens/user_profile.dart';

class BottomBar extends StatefulWidget{
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  @override
  Widget build(BuildContext context) {
    bool home_active = true;
    bool category_active = false;
    bool foods_active = false;
    bool account_active = false;
    bool cart_active = false;
    // TODO: implement build

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: Colors.transparent,
      elevation: 9.0,
      clipBehavior: Clip.antiAlias,
      child: Container(

        height: 50.0,
        decoration: BoxDecoration(

            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)
            ),
            color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                children: [
                  home_active ? Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Container(

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(4,8),
                                  blurRadius: 10
                              )
                            ]
                        ),

                        child: IconButton(icon: Icon(Icons.home, color: Colors.white,) )),
                  )
                      : IconButton(icon: Icon(Icons.home, color: Colors.grey,) ,
                  onPressed: (){

                  },
                  ),
                  category_active ? Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Container(

                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.redAccent,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(4,8),
                                  blurRadius: 10
                              )
                            ]
                        ),

                        child: IconButton(icon: Icon(Icons.dashboard, color: Colors.white,) )),
                  )
                      : IconButton(icon: Icon(Icons.dashboard,size: 20, color: Colors.grey,) ,
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoryList()));
                    },
                  ),

                  foods_active ? Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Container(

                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.redAccent,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(4,8),
                                  blurRadius: 10
                              )
                            ]
                        ),

                        child: IconButton(icon: Icon(Icons.fastfood, color: Colors.white,) )),
                  )
                      : IconButton(icon: Icon(Icons.fastfood,size: 20, color: Colors.grey,) ,
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Foods()));
                    },
                  ), cart_active ? Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Container(

                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.redAccent,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(4,8),
                                  blurRadius: 10
                              )
                            ]
                        ),

                        child: IconButton(icon: Icon(Icons.shopping_basket, color: Colors.white,) )),
                  )
                      : IconButton(icon: Icon(Icons.shopping_basket,size: 20, color: Colors.grey,) ,
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CartPage()));
                    },
                  ),
                  account_active ? Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Container(

                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.redAccent,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(4,8),
                                  blurRadius: 10
                              )
                            ]
                        ),

                        child: IconButton(icon: Icon(Icons.person_outline, color: Colors.white,) )),
                  )
                      : IconButton(icon: Icon(Icons.person_outline,size: 20, color: Colors.grey,) ,
                    onPressed: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileThreePage()));
                    },
                  ),


                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}