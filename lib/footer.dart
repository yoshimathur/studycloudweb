import 'package:flutter/material.dart';

import 'main.dart';

import 'package:url_launcher/url_launcher.dart';

final Uri _emailLaunchUrl = Uri(
  scheme: 'mailto',
  path: 'hills.studycloud@gmail.com',
  query: 'subject=Contact Us&body=What\'s up?'
);

class footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(16, 50, 16, 50),
      color: studycloudred,
      child: Center(
          child: Column(
            children: [
//              Container(
//                  padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
//                  child: Text('· Yash Mathur ·',
//                    style: TextStyle(fontFamily: 'Alegreya', fontSize: 17, color: Colors.white), textAlign: TextAlign.center,)
//              ),
              Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: SelectableText('· (732) 809-0321 ·',
                  style: TextStyle(fontFamily: 'Alegreya', fontSize: 17, color: Colors.white), textAlign: TextAlign.center, toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
                onTap: () {
                  launch('tel://7328090321');
                },),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: SelectableText('· hills.studycloud@gmail.com ·',
                  style: TextStyle(fontFamily: 'Alegreya', fontSize: 17, color: Colors.white), textAlign: TextAlign.center, toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
                onTap: () {
                  launch(_emailLaunchUrl.toString());
                },),
              ),
            ],
          )
      ),
    );
  }
}