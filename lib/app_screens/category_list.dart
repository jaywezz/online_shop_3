import 'package:flutter/material.dart';
import 'package:onlineshop3/models/categoriesData.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/widgets/category_list_widget.dart';
import 'package:onlineshop3/widgets/menu_dashboard.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<List<CategoriesData>>.value(
              value: DatabaseService().categoriesList
          ),

        ],
        child: ListView(
          children: <Widget>[
            Container(
              child: CategoryListWidget(),
            )
          ],
        )
    );
  }
}
