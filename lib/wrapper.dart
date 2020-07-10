import 'package:flutter/material.dart';
import 'package:onlineshop3/app_screens/home.dart';
import 'package:onlineshop3/app_screens/home_screen2.dart';
import 'package:onlineshop3/authentication/authenticate.dart';
import 'package:onlineshop3/models/subCategories.dart';
import 'package:onlineshop3/models/userData.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/widgets/bottom_navigation2.dart';
import 'package:provider/provider.dart';

import 'app_screens/home_screen.dart';
import 'models/cartData.dart';
import 'models/categoriesData.dart';
import 'models/productsData.dart';
import 'models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user == null){
      print("user is null");
      return Authenticate();
    }else{
      print("a user was returned ");

      return AnimatedBottomBar();
    }

  }
}
