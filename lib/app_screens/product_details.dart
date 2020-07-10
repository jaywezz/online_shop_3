import 'package:flutter/material.dart';
import 'package:onlineshop3/widgets/menu_dashboard.dart';

class ProductDetails extends StatefulWidget{
  final assetPath, product_price, product_name;


  const ProductDetails({Key key, this.assetPath, this.product_price, this.product_name}) : super(key: key);@override
  _ProductDetailsState createState() {

    return  _ProductDetailsState();
  }
}
class _ProductDetailsState extends State<ProductDetails>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
          backgroundColor: Colors.deepOrange,
          elevation: 0,
          title: Text('Details' ,style: TextStyle(fontSize: 20, color: Colors.white),),
          actions: <Widget>[
            TopBarIcons(context)
          ]
      ),
      body: ListView(
        children: [
          SizedBox(height: 15.0,),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              widget.product_name,style: TextStyle(
              fontFamily: 'Varela',
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF17532),
            ),
            ),
          ),
          SizedBox(height: 15,),
          Hero(
            tag: widget.assetPath,
            child: Image.asset(widget.assetPath,
            height: 150.0,
            width: 100,
            fit: BoxFit.contain,),

          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              widget.product_name,style: TextStyle(
              color: Color(0xFF575E67),
              fontFamily: 'Varela',
              fontSize: 24.0
            ),
            ),

          ),
          SizedBox(height: 10,),
          Center(
            child: Text(
              "Cold creamy ice cream sandwiched between delicious deluxe cookies.\n"
                  " Pick your favourite deluxe cookies and ice cream flavour",style: TextStyle(
                color: Color(0xFF575E67),
                fontFamily: 'Varela',
                fontSize: 24.0
            ),
            ),

          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width -50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Color(0xFFF17532)
            ),
            child: Center(
              child: Text("Add to cart",style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Varela',
                fontWeight: FontWeight.bold,
                color: Colors.white
              ), ),
            ),
          )
        ],
      ),
    );
  }

}