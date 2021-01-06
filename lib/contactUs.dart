import 'package:flutter/material.dart';

import 'main.dart';
import 'footer.dart';

import 'package:url_launcher/url_launcher.dart';

final Uri _emailLaunchUrl = Uri(
  scheme: 'mailto',
  path: 'yoshi.mathur@gmail.com',
);

class contactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Cloud · Contact Us', style: TextStyle(fontSize: 30, fontFamily: 'Alegreya'),),
        backgroundColor: studycloudred,
        centerTitle: false,
      ),
      drawer: menu(),
      body: Center(
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    height: 500,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: new ExactAssetImage('assets/images/studycloudceo.png'),
                        fit: BoxFit.fitHeight
                      )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                    child: Text('Yash Mathur', style: TextStyle(fontFamily: 'Alegreya', fontSize: 30), textAlign: TextAlign.center,),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                    child: Text('Founder/Creator of Study Cloud', style: TextStyle(fontFamily: 'Alegreya', fontSize: 20), textAlign: TextAlign.center,),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text('I got the idea for Study Cloud during the summer leading into my junior year of high school (2019-2020). 2020 brought a lot of surprises, and with online schooling, I found myself with a lot of time on my hands. I used this time to teach myself to code and turn my dream into a reality.', style: TextStyle(fontSize: 20, fontFamily: 'Alegreya', fontStyle: FontStyle.italic), textAlign: TextAlign.center,),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: SelectableText(
                      'Feel free to contact me!\n· (732) 809-0321 ·\n· yoshi.mathur@gmail.com ·',
                      style: TextStyle(fontSize: 20, fontFamily: 'Alegreya'),
                      textAlign: TextAlign.center,
                      onTap: () {
                        launch(_emailLaunchUrl.toString());
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 100,
            ),
            footer()
          ],
        ),
      ),
    );
  }
}