import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:onlineshop3/app_screens/foods_screen.dart';
import 'package:onlineshop3/app_screens/home_screen.dart';
import 'package:onlineshop3/app_screens/onboard.dart';
import 'package:onlineshop3/services/auth.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/widgets/bottom_navigation2.dart';
import 'package:onlineshop3/widgets/drawer_light.dart';
import 'package:onlineshop3/wrapper.dart';
import 'package:provider/provider.dart';

import 'app_screens/admin.dart';
import 'app_screens/home.dart';
import 'app_screens/login.dart';
import 'models/orderData.dart';
import 'models/user.dart';
import 'models/userData.dart';

void main() {
  MpesaFlutterPlugin.setConsumerKey('KuaA82NjJpgZsu8tg0k4T177QhAVEVVH');
  MpesaFlutterPlugin.setConsumerSecret('rXrbexaPh5twzLA9 rXrbexaPh5twzLA9');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return

        MultiProvider(
          providers: [
            StreamProvider<User>.value(
            value: AuthService().user,),

          ],

            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Wrapper()
            ),
          );



  }
}



