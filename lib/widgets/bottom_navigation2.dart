

import 'package:flutter/material.dart';
import 'package:onlineshop3/app_screens/cart.dart';
import 'package:onlineshop3/app_screens/categories.dart';
import 'package:onlineshop3/app_screens/category_list.dart';
import 'package:onlineshop3/app_screens/foods_screen.dart';
import 'package:onlineshop3/app_screens/home_screen2.dart';
import 'package:onlineshop3/app_screens/settings_screen.dart';
import 'package:onlineshop3/app_screens/user_profile.dart';
import 'package:onlineshop3/models/categoriesData.dart';
import 'package:onlineshop3/models/orderData.dart';
import 'package:onlineshop3/models/productsData.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/models/userData.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/widgets/drawer.dart';
import 'package:onlineshop3/widgets/menu_dashboard.dart';
import 'package:onlineshop3/wrapper.dart';
import 'package:provider/provider.dart';

class AnimatedBottomBar extends StatefulWidget {



  @override
  _AnimatedBottomBarState createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar> {
   int _currentPage;
  @override
  void initState() {

   _currentPage = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<ProductsData>>.value(
          value:DatabaseService().products,),

        StreamProvider<List<CategoriesData>>.value(
            value: DatabaseService().categoriesList),
        StreamProvider<List<UserData>>.value(
            value:DatabaseService().usersById(user.uid)
        ),
        StreamProvider<List<OrderData>>.value(
          value:DatabaseService().ordersByUID(user.uid),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            elevation: 0,
            actions: <Widget>[
              TopBarIcons(context),
            ]
        ),
        drawer: AppDrawer(),
        body: getPage(_currentPage),
        bottomNavigationBar: AnimatedBottomNav(
            currentIndex: _currentPage,
            onChange: (index) {
              setState(() {
                _currentPage = index;
              });
            }),
      ),
    );
  }

  getPage(int page) {
    switch(page) {
      case 0:
        return HomeScreen2();
      case 1:
        return  CategoryList();
      case 2:
        return  Foods();
      case 3:
        return  CartPage();
      case 4:
        return ProfileThreePage();
    }
  }
}

class AnimatedBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onChange;
  const AnimatedBottomNav({Key key, this.currentIndex, this.onChange})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => onChange(0),
              child: BottomNavItem(
                icon: Icons.home,
                title: "Home",
                isActive: currentIndex == 0,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange(1),
              child: BottomNavItem(
                icon: Icons.dashboard,
                title: "Category",
                isActive: currentIndex == 1,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange(2),
              child: BottomNavItem(
                icon: Icons.fastfood,
                title: "Foods",
                isActive: currentIndex == 2,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange(3),
              child: BottomNavItem(
                icon: Icons.shopping_cart,
                title: "Cart",
                isActive: currentIndex == 3,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange(4),
              child: BottomNavItem(
                activeColor: Colors.deepOrange,
                inactiveColor: Colors.grey,
                icon: Icons.person,
                title: "Account",
                isActive: currentIndex == 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final bool isActive;
  final IconData icon;
  final Color activeColor;
  final Color inactiveColor;
  final String title;
  const BottomNavItem(
      {Key key,
        this.isActive = false,
        this.icon,
        this.activeColor,
        this.inactiveColor,
        this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      duration: Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 200),
      child: isActive
          ? Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: activeColor ?? Colors.deepOrange,
              ),
            ),
            const SizedBox(height: 5.0),
            Container(
              width: 5.0,
              height: 5.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: activeColor ?? Colors.deepOrange,
              ),
            ),
          ],
        ),
      )
          : Icon(
        icon,
        color: inactiveColor ?? Colors.grey,
      ),
    );
  }
}
