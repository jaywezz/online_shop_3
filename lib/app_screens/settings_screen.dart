/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlineshop3/models/user.dart';
import 'package:onlineshop3/models/userData.dart';
import 'package:onlineshop3/services/database.dart';
import 'package:onlineshop3/widgets/settings_widget.dart';
import 'package:provider/provider.dart';

class SettingsThreePage extends StatelessWidget {
  static final String path = "lib/src/pages/settings/settings3.dart";
  final TextStyle headerStyle = TextStyle(
    color: Colors.grey.shade800,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<UserData>>.value(
          value:DatabaseService().usersById(user.uid),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            'Settings',
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: SettingWidget()
        ),
      ),
    );
  }


}
