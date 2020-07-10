import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomAppBar(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left:38.0,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(

                  ),
                  child: InkWell(
                     onTap: (){},
                      child: Icon(Icons.add_shopping_cart, size: 40,  color: Colors.grey)
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 40),
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.purple
                      
                  ),
                  child: Center(
                    child: InkWell(
                        onTap: (){},
                      child: Text("Buy Now", style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                      ),),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ),
    );
  }

}