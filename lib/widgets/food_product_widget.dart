import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:onlineshop3/app_screens/product_details_test.dart';
import 'package:onlineshop3/models/productsData.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:provider/provider.dart';

class FoodProduct extends StatefulWidget {
  @override
  _FoodProductState createState() => _FoodProductState();
}

class _FoodProductState extends State<FoodProduct> {

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<ProductsData>>(context) ?? [];
    return GridView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index){
          return
            SingleProductFood(
            product_name: products[index].productName,
            product_picture: products[index].images,
            product_description: products[index].productDescription,
            product_category: products[index].producsCategory,
            product_price: products[index].productPrice,
            product_rating: products[index].productRating,
              product_available: products[index].productsAvailable,
              product_id: products[index].producsId,
          );

        }
    );
  }
}

class SingleProductFood extends StatelessWidget {

  final String product_name;
  final double product_price;
  final List product_picture;
  final String product_description;
  final String product_category;
  final int product_rating;
  final int product_available;
  final String product_id;


  const SingleProductFood({Key key,this.product_available,this.product_id, this.product_name, this.product_price, this.product_picture, this.product_description, this.product_category, this.product_rating}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return  Stack(
      children: <Widget>[
             Container(

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
            child: Column(

            children: <Widget>[
              Padding(
              padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProductDetailsTest(
                          product_name: product_name,
                          product_price: product_price,
                          product_picture: product_picture,
                          product_rating: product_rating,
                          product_category: product_category,
                          product_description: product_description,
                          product_available: product_available,


                        ))
                    );
                  },
                  child: Image.network(product_picture[0],filterQuality: FilterQuality.low,
                    fit: BoxFit.cover,),
                )
              ),

            ],
            ),
            ),
        Positioned(
          top: 3,

          child: Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Container(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: IconButton(
                        icon: Icon(Icons.add_shopping_cart,size: 17, color: Colors.red,),
                      onPressed: () async{
                        await DatabaseService().AddToCart(
                          product_id,
                          product_name,
                          product_picture[0],
                          product_category,
                          product_price.toDouble(),
                          user.uid,
                          1,

                        );
                        print('added to cart');
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:8.0),
                    child: Icon(Icons.favorite,size: 18, color: Colors.red,),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 1,
          child: Container(
            width: 200,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(10),
                color: Colors.white70,
              ),
              height: 50,

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(product_name,style: TextStyle(
                                color:Colors.black,fontWeight: FontWeight.bold
                            ),),

                            //Product price

                          ],
                        ),
                        Text(product_price.toString(),style:
                        TextStyle(
                            color:Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                        ),),

                        //Row
                      ],
                    ),
                    // product text name

                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("4.4",style:
                            TextStyle(
                                color:Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 10
                            ),),
                            Icon(Icons.star, size: 10, color: Colors.yellow,),
                            Icon(Icons.star, size: 10, color: Colors.yellow,),
                            Icon(Icons.star, size: 10, color: Colors.yellow,),
                            Icon(Icons.star, size: 10, color: Colors.yellow,)
                          ],
                        ),
                        Text("Available 19",style:
                        TextStyle(
                            color:Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 10
                        ),),
                      ],

                    )
                    //Row
                    //Number rating, star icon       available
                  ],
                ),
              )
          ),
        ),
      ],
    );

  }
}

