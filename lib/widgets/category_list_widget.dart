import 'package:flutter/material.dart';
import 'package:onlineshop3/app_screens/categories.dart';
import 'package:onlineshop3/app_screens/foods_screen.dart';
import 'package:onlineshop3/models/categoriesData.dart';
import 'package:provider/provider.dart';

class CategoryListWidget extends StatefulWidget {
  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<CategoriesData>>(context) ?? [];

    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(

        padding: EdgeInsets.all(6),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {

          return InkWell(
          onTap: (){
            if(categories[index].categoryName == 'foods'){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Foods()));
            }else {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Categories(category: categories[index].categoryName,)));
            }
          },

            child: Card(
              elevation: 3,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 125,
                    width: 110,
                    padding:
                    EdgeInsets.only(left: 0, top: 10, bottom: 70, right: 20),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(categories[index].categoryImage), fit: BoxFit.cover)),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          categories[index].categoryName,
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.w700,
                              fontSize: 17),
                        ),


                      ],
                    ),
                  )
                ],
              ),
            )
          );
        },
      ),
    );
  }
}
