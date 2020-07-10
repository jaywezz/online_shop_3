import 'package:flutter/material.dart';
import 'package:onlineshop3/models/productsData.dart';
import 'package:provider/provider.dart';

class RandomFoodProduct extends StatefulWidget {
  @override
  _RandomFoodProductState createState() => _RandomFoodProductState();
}

class _RandomFoodProductState extends State<RandomFoodProduct> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<ProductsData>>(context) ?? [];
    return Container(
        height: 180,
        child:ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index){
              return  Stack(
                children: <Widget>[
                  Container(
                      height: 180,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)

                      ),
                      child: Image.network(products[1].images[0],width: 440, height: 120,
                      fit: BoxFit.cover,
                      )),
                  Positioned(
                    top: 5,
                    right: 5,
                    child:  Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200],
                                  offset: Offset(2,5),
                                  blurRadius: 7
                              )
                            ]
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.favorite, size: 16,color: Colors.red,)
                        )),
                  )
                ],

              );
            }
        )
    );
  }
}
