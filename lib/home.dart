import 'package:flutter/material.dart';

import 'main.dart';
import 'footer.dart';

import 'package:url_launcher/url_launcher.dart';

class home extends StatelessWidget {

  final messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Study Cloud', style: TextStyle(fontSize: 30, fontFamily: 'Alegreya'), textAlign: TextAlign.center,),
          backgroundColor: studycloudred,
          centerTitle: false,
        ),
        drawer: null,
        body: ListView(
          children: [
            AspectRatio(
              aspectRatio: 910/617,
              child: Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                      'Welcome to Study Cloud!',
                      style: TextStyle(fontSize: 75, color: studycloudyellow, fontFamily: 'Alegreya'),
                      textAlign: TextAlign.center
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: new ExactAssetImage('assets/images/studycloudwelcomepage.png'),
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Text('Download the App!', style: TextStyle(fontSize: 40, color: Colors.black, fontFamily: 'Alegreya'),),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 125,
                  padding: EdgeInsets.all(8),
                  child: Image.asset('assets/images/studycloudlogo.png'),
                ),
                Container(
                  width: 200,
                  child: Column(
                    children: [
                      FlatButton(
                        padding: EdgeInsets.all(4),
                        child: Image.asset('assets/images/downloadtoappstore.png'),
                        onPressed: () async {
                          String url = 'https://apps.apple.com/us/app/study-cloud-us/id1521034983';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw "Could not launch $url";
                          }
                        },
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(4),
                        child: Image.asset('assets/images/downloadongoogleplay.png'),
                        onPressed: () async {
                          String url = 'https://play.google.com/store/apps/details?id=com.yashmathur.study_cloud_android';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw "Could not launch $url";
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: Text("Get help. Give help.", style: TextStyle(fontSize: 20, fontFamily: 'Alegreya', fontStyle: FontStyle.italic, color: Colors.black),),
            ),
            Container(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: studycloudblue, width: 5),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.all(32),
                child: aboutUsDescription,
              ),
            ),
            Container(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset('assets/images/getStarted1.png'),
                  ),
                  Expanded(
                    child: Image.asset('assets/images/getStarted2.png'),
                  ),
                  Expanded(
                    child: Image.asset('assets/images/getStarted3.png'),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: studycloudred, width: 5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Support',
                      style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'ALegreya'), textAlign: TextAlign.left,),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 50),
                      child: TextField(
                        controller: messageTextController,
                        cursorColor: studycloudblue,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: studycloudred)
                          ),
                          hintText: 'What\'s up?'
                        ),
                        maxLines: 6,
                        style: TextStyle(fontSize: 15, fontFamily: 'Alegreya', color: Colors.black),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ButtonTheme(
                        height: 50,
                        child: FlatButton(
                          color: studycloudblue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Text('Send',
                            style: TextStyle(fontSize: 20, fontFamily: 'Alegreya', color: Colors.white),
                          ),
                          onPressed: () async {
                            if(messageTextController.text.isNotEmpty) {
                              String url = 'mailto:hills.studycloud@gmail.com?subject=Support&body=${messageTextController.text}';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw "Could not launch $url";
                              }
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
            ),
            footer()
          ],
        )
    );
  }
}