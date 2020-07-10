import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Container(
        height: 100,
        child: ListView.builder(
          itemCount: 8,
            scrollDirection:  Axis.horizontal,
            itemBuilder: (_, index){
              return Container(
                  width:  60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red[100],
                            offset: Offset(2,1),
                            blurRadius: 10
                        )
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/food1.jpeg'),
                  ),
              );
            }
        ),
      ),
    );
  }
}
