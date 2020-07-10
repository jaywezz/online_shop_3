import 'package:flutter/material.dart';
import 'package:onlineshop3/app_screens/user_profile.dart';
import 'package:onlineshop3/models/userData.dart';
import 'package:onlineshop3/services/auth.dart';
import 'package:onlineshop3/wrapper.dart';
import 'package:provider/provider.dart';

class SettingWidget extends StatefulWidget {
  @override
  _SettingWidgetState createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  final TextStyle headerStyle = TextStyle(
    color: Colors.grey.shade800,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user_data= Provider.of<List<UserData>>(context) ?? [];

    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "ACCOUNT",
          style:headerStyle
        ),
        const SizedBox(height: 10.0),
        Card(
          elevation: 0.5,
          margin: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 0,
          ),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProfileThreePage()));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/b2.jpg'),
                  ),
                  title: Text(user_data[0].names),

                ),
              ),
              _buildDivider(),
              SwitchListTile(
                activeColor: Colors.deepOrangeAccent,
                value: true,
                title: Text("Allow google maps location"),
                onChanged: (val) {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        Text(
          "PUSH NOTIFICATIONS",
          style: headerStyle,
        ),
        Card(
          margin: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 0,
          ),
          child: Column(
            children: <Widget>[
              SwitchListTile(
                activeColor: Colors.purple,
                value: true,
                title: Text("Receive notification"),
                onChanged: (val) {},
              ),
              _buildDivider(),
              SwitchListTile(
                activeColor: Colors.purple,
                value: false,
                title: Text("Receive newsletter"),
                onChanged: null,
              ),
              _buildDivider(),
              SwitchListTile(
                activeColor: Colors.purple,
                value: true,
                title: Text("Receive Offer Notification"),
                onChanged: (val) {},
              ),
              _buildDivider(),
              SwitchListTile(
                activeColor: Colors.purple,
                value: true,
                title: Text("Receive App Updates"),
                onChanged: null,
              ),
            ],
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 0,
          ),
          child: ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () async{
              await _auth.signOut().then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Wrapper())));
            },
          ),
        ),
        const SizedBox(height: 60.0),
      ],
    );

  }
  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade300,
    );
  }
}
