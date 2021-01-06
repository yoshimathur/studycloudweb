import 'package:flutter/material.dart';

import 'main.dart';
import 'footer.dart';

import 'package:url_launcher/url_launcher.dart';

final Uri _emailLaunchUrl = Uri(
  scheme: 'mailto',
  path: 'hills.studycloud@gmail.com',
  query: 'subject=Support'
);

class support extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Cloud · Support', style: TextStyle(fontSize: 30, fontFamily: 'Alegreya'),),
        backgroundColor: studycloudred,
        centerTitle: false,
      ),
      drawer: menu(),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 50, 16, 16),
            child: SelectableText('Email us with any questions you have at hills.studycloud@gmail.com, and we will get back to you as soon as possible. We will also periodically add commonly asked questions below, so please check to see if your question was already asked before emailing. Thank you!',
              style: TextStyle(color: studycloudred, fontFamily: 'Alegreya', fontSize: 20),
              textAlign: TextAlign.left,
              onTap: () {
                launch(_emailLaunchUrl.toString());
              },
            ),
          ),
          Column(
            children: [
              Container(
                height: 1000,
              )
            ],
          ),
          footer()
        ],
      ),
    );
  }
}