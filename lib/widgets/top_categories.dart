import 'package:flutter/material.dart';
import 'package:onlineshop3/app_screens/foods_screen.dart';

class TopCategories extends StatefulWidget {
  @override
  _TopCategoriesState createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {

  final double icon_size = 18;
  final double font_size = 15;
  @override
  Widget build(BuildContext context) {
    return Container(

        height: 180,
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 4,


          children: <Widget>[
            Container(
              decoration: BoxDecoration(

              ),
              child:Column(
                children: <Widget>[
                  Container(
                    height : 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                       color: Colors.deepOrange
                    ),
                    child: IconButton(
                      icon:Icon(Icons.library_books,  size: 18, color: Colors.white,),
                      onPressed: (){},
                    ),
                  ),
                  SizedBox(height: 6,),
                  Text("Books",
                    style: TextStyle(
                        fontSize: font_size
                    ),)
                ],
              ),

            ),
            Container(

              child:Column(
                children: <Widget>[
                  Container(
                    height : 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red
                    ),
                    child: IconButton(
                      icon:Icon(Icons.camera_alt,  size: 18, color: Colors.white,),
                      onPressed: (){},
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("Cameras",
                    style: TextStyle(
                        fontSize: font_size
                    ),)
                ],
              ),

            ),
            Container(

              child:Column(
                children: <Widget>[
                  Container(
                    height : 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple
                    ),
                    child: IconButton(
                      icon:Icon(Icons.laptop_chromebook,  size: 18, color: Colors.white,),
                      onPressed: (){},
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("Laptops",
                    style: TextStyle(
                        fontSize: font_size
                    ),)
                ],
              ),

            ),

            Container(

              child:Column(
                children: <Widget>[
                  Container(
                    height : 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green
                    ),
                    child: IconButton(
                      icon:Icon(Icons.phone_android,  size: 18, color: Colors.white,),
                      onPressed: (){},
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("Phones",
                    style: TextStyle(
                        fontSize: font_size
                    ),)
                ],
              ),

            ),
            Container(

              child:Column(
                children: <Widget>[
                  Container(
                    height : 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink
                    ),
                    child: IconButton(
                      icon:Icon(Icons.audiotrack,  size: 18, color: Colors.white,),
                      onPressed: (){},
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("Woofers",
                    style: TextStyle(
                        fontSize: font_size
                    ),)
                ],
              ),

            ),
            Container(

              child:Column(
                children: <Widget>[
                  Container(
                    height : 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green
                    ),
                    child: IconButton(
                      icon:Icon(Icons.fastfood,  size: 18, color: Colors.white,),
                      onPressed: (){},
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("Fastfoods",
                    style: TextStyle(
                        fontSize: font_size
                    ),)
                ],
              ),
            ),
            Container(

              child:Column(
                children: <Widget>[
                  Container(
                    height : 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepOrange
                    ),
                    child: IconButton(
                      icon:Icon(Icons.free_breakfast,  size: 18, color: Colors.white,),
                      onPressed: (){},
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("Laptops",
                    style: TextStyle(
                        fontSize: font_size
                    ),)
                ],
              ),
            ),
            Container(
              child:Column(
                children: <Widget>[
                  Container(
                    height : 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple
                    ),
                    child: IconButton(
                      icon:Icon(Icons.face,  size: 18, color: Colors.white,),
                      onPressed: (){},
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("Fashion",
                    style: TextStyle(
                        fontSize: font_size
                    ),)
                ],
              ),
            ),

          ],
        )
    );;
  }
}
