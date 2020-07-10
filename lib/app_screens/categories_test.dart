import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:onlineshop3/widgets/menu_dashboard.dart';

class CategoryTest extends StatefulWidget{
  @override
  _CategoryTestState createState() {
    // TODO: implement createState
    return _CategoryTestState();
  }

}

class _CategoryTestState extends State<CategoryTest>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "Ladies",
                style: TextStyle(color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w300),
              ),
            ),
            backgroundColor: Colors.deepOrange,
            elevation: 0,
            actions: <Widget>[
              TopBarIcons(context)
            ],
          ),
          body: ListView(

            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/b2.jpg'),
                    fit: BoxFit.cover
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:25.0, top:40),
                  child: Align(

                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Text("BRANDED \nJEANS", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          letterSpacing: 1,
                          color: Colors.white
                        ),),
                        SizedBox(height: 20,),
                        Text("UP T0 70%", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            wordSpacing: 2,
                            letterSpacing: 1,
                            color: Colors.red
                        ),)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text("Sub Category", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black
                    ),),

                  ],

                ),
              )

            ],
          ),
        )
    );
  }
}