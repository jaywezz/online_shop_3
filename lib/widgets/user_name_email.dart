import 'package:flutter/material.dart';
import 'package:onlineshop3/models/cartData.dart';
import 'package:onlineshop3/models/userData.dart';
import 'package:onlineshop3/utils/CustomTextStyle.dart';
import 'package:provider/provider.dart';

class UserNameAndEmail extends StatefulWidget {
  @override
  _UserNameAndEmailState createState() => _UserNameAndEmailState();
}

class _UserNameAndEmailState extends State<UserNameAndEmail> {
  @override
  Widget build(BuildContext context) {
    final user= Provider.of<List<UserData>>(context) ?? [];

    return  Column(
      children: <Widget>[
        Text(
          user[0].names ?? 'No Name',
          style: CustomTextStyle.textFormFieldBlack
              .copyWith(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900),
        ),
    Text(
    user[0].email ?? 'No Name',
    style: CustomTextStyle.textFormFieldMedium
        .copyWith(
    color: Colors.grey.shade700,
    fontSize: 14),
    ),
      ],
    );

  }
}
