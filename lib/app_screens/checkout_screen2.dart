import 'package:flutter/material.dart';
import 'package:onlineshop3/models/cartData.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/models/userData.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/widgets/order_summary.dart';
import 'package:onlineshop3/widgets/payments.dart';
import 'package:onlineshop3/widgets/shippment.dart';
import 'package:provider/provider.dart';

class CheckOutScreen extends StatefulWidget {
  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<CartData>>.value(
            value:DatabaseService().cartProducts(user.uid),

        ),
        StreamProvider<List<UserData>>.value(
         value:DatabaseService().usersById(user.uid))
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          actions: <Widget>[

          ],
          title: Text(
            'CheckOut', style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Colors.white
          ),
          ),
        ),
        body: ListView(

           children: <Widget>[
             SizedBox(height: 5,
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: TabBar(
                 controller: _tabController,
                 indicatorColor: Colors.green,
                 isScrollable: true,
                 labelColor: Colors.redAccent,
                 labelPadding: EdgeInsets.only(right: 45),
                 unselectedLabelColor: Colors.grey,
                 tabs: <Widget>[
                   Tab(
                     child: Text(
                       "Shippment",
                       style: TextStyle(fontFamily: 'Varela',
                           fontSize: 19),
                     ),
                   ),
                   Tab(
                     child: Text(
                       "Payment",
                       style: TextStyle(fontFamily: 'Varela',
                           fontSize: 19),
                     ),
                   ),
                   Tab(
                     child: Text(
                       "Summary",
                       style: TextStyle(fontFamily: 'Varela',
                           fontSize: 19),
                     ),
                   ),
                 ],
               ),
             ),
             Container(
               height: 800,
               width: double.infinity,
               child: TabBarView(

                   controller: _tabController,
                   children: [
                     //sub category 1
                     Shippment(),
                     Payment(),
                     OrderSummary()
                   ]
               ),

             )
           ],
        ),
      ),
    );
  }
}
