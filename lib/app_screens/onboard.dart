
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:onlineshop3/app_screens/home_screen2.dart';
//import 'package:testapp/core/presentation/res/assets.dart';
import 'package:onlineshop3/widgets/swiper_pagination.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../wrapper.dart';

class Onboarding extends StatefulWidget {
  static final String path = "lib/src/pages/onboarding/intro3.dart";
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final SwiperController _swiperController = SwiperController();
  final int _pageCount = 3;
  int _currentIndex = 0;
  final List<String> titles = [
    "Stay at home,  let us deliver",
    "We delivery exactly to your door step",
    "And enjoy great discounts ever"
  ];
  final List<Color> pageBgs = [
    Colors.redAccent,
    Colors.deepOrange,
    Colors.deepOrangeAccent
  ];
  final List<String> imagesUrls = [
    "assets/images/delivery.jpeg",
    "assets/images/shop.jpeg",
    "assets/images/discounts.jpeg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: 300,
              margin: const EdgeInsets.only(left: 8.0, right: 8.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Swiper(
                    index: _currentIndex,
                    controller: _swiperController,
                    itemCount: _pageCount,
                    onIndexChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    loop: false,
                    itemBuilder: (context, index) {
                      return _buildPage(
                          title: titles[index],
                           image: imagesUrls[index],
                          pageBg: pageBgs[index]);
                    },
                    pagination: SwiperPagination(
                        builder: CustomPaginationBuilder(
                            activeSize: Size(10.0, 29.0),
                            size: Size(10.0, 24.0),
                            color: Colors.deepOrangeAccent)),
                  )),
              SizedBox(height: 10.0),
              _buildButtons(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      margin: const EdgeInsets.only(right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            textColor: Colors.redAccent,
            child: Text("Skip"),
            onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen2()));
            },
          ),
          IconButton(
            icon: Icon(_currentIndex < _pageCount - 1
                ? Icons.arrow_forward_ios
                : Icons.check, color: Colors.redAccent,),
            onPressed: () async {
              if (_currentIndex < _pageCount - 1)
                _swiperController.next();
              else {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Wrapper()));
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildPage({String title, String image, Color pageBg}) {
    final TextStyle titleStyle = TextStyle(
        fontWeight: FontWeight.w500, fontSize: 20.0, color: Colors.white);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 40.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0), color: pageBg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: titleStyle,
          ),
          SizedBox(height: 30.0),
          Expanded(
            child: ClipOval(
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover)),
                )),
          ),
          SizedBox(height: 50.0),
        ],
      ),
    );
  }
}
