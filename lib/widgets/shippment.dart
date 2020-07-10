import 'package:flutter/material.dart';
import 'package:onlineshop3/models/userData.dart';
import 'package:onlineshop3/utils/CustomTextStyle.dart';
import 'package:onlineshop3/widgets/address_edit_form.dart';
import 'package:provider/provider.dart';

class Shippment extends StatefulWidget {
  @override
  _ShippmentState createState() => _ShippmentState();
}

class _ShippmentState extends State<Shippment> {
  @override
  Widget build(BuildContext context) {
    final user_data= Provider.of<List<UserData>>(context) ?? [];
    print('user_data.length');
    print(user_data.length);
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                   user_data[0].names ?? 'No Name',
                    style: CustomTextStyle.textFormFieldSemiBold
                        .copyWith(fontSize: 14),
                  ),
                ],
              ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Text(
                user_data[0].address ?? 'No address set',
                style: CustomTextStyle.textFormFieldMedium
                    .copyWith(fontSize: 12, color: Colors.grey.shade800),
              ),
            ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Text(
                 user_data[0].city ,
                  style: CustomTextStyle.textFormFieldMedium
                      .copyWith(fontSize: 12, color: Colors.grey.shade800),
                ),
              ),



              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Mobile : ",
                      style: CustomTextStyle.textFormFieldMedium
                          .copyWith(fontSize: 12, color: Colors.grey.shade800)),
                  TextSpan(
                      text: user_data[0].phone_number.toString() ?? 'You have not set a phone number',
                      style: CustomTextStyle.textFormFieldBold
                          .copyWith(color: Colors.black, fontSize: 12)),
                ]),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey.shade300,
                height: 1,
                width: double.infinity,
              ),
          Container(
            child: Row(
              children: <Widget>[
                Spacer(
                  flex: 2,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddressEditForm()));

                  },
                  child: Text(
                    "Edit / Change",
                    style: CustomTextStyle.textFormFieldSemiBold
                        .copyWith(fontSize: 12, color: Colors.indigo.shade700),
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                Spacer(
                  flex: 3,
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: Colors.grey,
                ),
                Spacer(
                  flex: 3,
                ),
//                FlatButton(
//                  onPressed: () {},
//                  child: Text("Add New Address",
//                      style: CustomTextStyle.textFormFieldSemiBold
//                          .copyWith(fontSize: 12, color: Colors.indigo.shade700)),
//                  splashColor: Colors.transparent,
//                  highlightColor: Colors.transparent,
//                ),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
              SizedBox(height: 14,),
              //Shippment time
              Container(

                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.tram),
                          SizedBox(width: 20,),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left:18.0),
                              child: Text(
                                'Usually delivered in Nyahururu town between a span of 3 days,'
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left:18.0),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Will be delivered  : ",
                                style: CustomTextStyle.textFormFieldMedium
                                    .copyWith(fontSize: 12, color: Colors.grey.shade800)),
                            TextSpan(
                                text: "Wednesday July 19",
                                style: CustomTextStyle.textFormFieldBold
                                    .copyWith(color: Colors.black, fontSize: 12)),
                            TextSpan(
                                text: "9.00am - 1.00pm",
                                style: CustomTextStyle.textFormFieldBold
                                    .copyWith(color: Colors.black, fontSize: 12)),

                          ]),

                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );


  }
}
