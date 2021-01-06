import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'footer.dart';
import 'main.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class requestHelp extends StatefulWidget{
  _reqHelpState createState() => _reqHelpState();
}

class _reqHelpState extends State<requestHelp>{

  String error = "";
  final searchBar = TextEditingController();
  List<String> helpersArray = [];

  noUserError() {
    setState(() {
      error = 'Please log in first!';
      print('User not logged in!');
    });
  }

  noClassMatesError() {
    setState(() {
      error = 'No local helpers could be found! Try searching the cloud!';
      print('No helpers!');
    });
  }

  setUpHelpersArray(String helperUID, String userUID) {
    setState( () {
      if(helperUID != userUID){
        helpersArray.add(helperUID);
      }
    });
  }

  Future searchLocal(String course) async {

    final cleanedCourses = coursesArray.map((e) => e.toLowerCase().trim(),).toList();
    helpersArray = [];

    if(cleanedCourses.contains(course)) {
      final user = await FirebaseAuth.instance.currentUser();
      String uid = user.uid;
      int courseIndex = cleanedCourses.indexOf(course);
      print(courseIndex);

      FirebaseFirestore.instance.collection("Users").doc(uid).get().then((userDocument) async {
        int count = 0;
        final district = await userDocument.get("District");
        FirebaseFirestore.instance.collection("Users")
            .where("District", isEqualTo: district)
            .orderBy("Tag")
            .get()
            .then((schoolSnapshot) async {
          if (schoolSnapshot.size != 0) {
            for (var doc in schoolSnapshot.docs) {
              if (count == 15) {
                break;
              }
              if (doc.id.toString()!= uid) {
                if (doc.data().containsKey("Helper")) {
                  final helperOptional = await doc.get("Helper");
                  if (helperOptional == true) {

                    if (doc.data().containsKey("Courses")) {
                      final List<dynamic> helperCourses = await doc.get("Courses");

                      if (helperCourses.contains(courseIndex)) {
                        final String helperUID = doc.get("uid").toString();

                        setState(() {
                          helpersArray.add(helperUID);
                        });

                        count++;
                      }
                    }
                  }
                }
              }
            }
            if (helpersArray.length == 0) {
              setState(() {
                error = 'No local helpers could be found! Try searching the cloud!';
              });
            }
          } else {
            setState(() {
              error = 'Students in your district have not yet registered. Spread the app, so you can get the help you need!';
            });
          }
        }).catchError((onError) {
          setState(() {
            error = onError.toString();
            print(onError.toString());
          });
        });
      }).catchError((onError) {
        setState(() {
          error = onError.toString();
          print(onError.toString());
        });
      });
    } else {
      setState(() {
        error = 'No results. Invalid search! Check Program of Studies to make sure you are searching for a valid course name.';
      });
    }
  }

  Future searchCloud(String course) async {

    final cleanedCourses = coursesArray.map((e) => e.toLowerCase().trim(),).toList();
    helpersArray = [];

    if(cleanedCourses.contains(course)) {
      final user = await FirebaseAuth.instance.currentUser();
      String uid = user.uid;
      int courseIndex = cleanedCourses.indexOf(course);
      print(courseIndex);

      FirebaseFirestore.instance.collection("Users").doc(uid).get().then((userDocument) async {
        int count = 0;
        final district = await userDocument.get("District");
        FirebaseFirestore.instance.collection("Users")
            .orderBy("Tag")
            .get()
            .then((schoolSnapshot) async {
          if (schoolSnapshot.size != 0) {
            for (var doc in schoolSnapshot.docs) {
              if (count == 15) {
                break;
              }
              if (doc.id.toString()!= uid) {
                if (doc.data().containsKey("Helper")) {
                  final helperOptional = await doc.get("Helper");
                  if (helperOptional == true) {

                    if (doc.data().containsKey("Courses")) {
                      final List<dynamic> helperCourses = await doc.get("Courses");

                      if (helperCourses.contains(courseIndex)) {
                        final String helperUID = doc.id;

                        setState(() {
                          helpersArray.add(helperUID);
                        });

                        count++;
                      }
                    }
                  }
                }
              }
            }
            if (helpersArray.length == 0) {
              setState(() {
                error = 'No local helpers could be found! Try searching the cloud!';
              });
            }
          } else {
            setState(() {
              error = 'Students in your district have not yet registered. Spread the app, so you can get the help you need!';
            });
          }
        }).catchError((onError) {
          setState(() {
            error = onError.toString();
            print(onError.toString());
          });
        });
      }).catchError((onError) {
        setState(() {
          error = onError.toString();
          print(onError.toString());
        });
      });
    } else {
      setState(() {
        error = 'No results. Invalid search! Check Program of Studies to make sure you are searching for a valid course name.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Cloud · Req Help', style: TextStyle(fontSize: 30, fontFamily: 'Alegreya'),),
        backgroundColor: studycloudred,
        centerTitle: false,
      ),
      drawer: menu(),
      body: FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if(snapshot.hasData) {
            return ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: FlatButton(
                      color: studycloudblue,
                      child: Text('Program of Studies', style: TextStyle(color: Colors.white, fontFamily: 'Alegreya', fontSize: 20),),
                      onPressed: () {
                        showDialog(context: context, builder: (BuildContext context) {
                          return Dialog(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      icon: Icon(Icons.cancel),
                                      color: studycloudblue,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text('Tap a course to copy!', style: TextStyle(color: studycloudred, fontSize: 20, fontFamily: 'Alegreya'), textAlign: TextAlign.center,),
                                  ),
                                  Expanded(
                                    child: ListView(
                                      children: [
                                        for (var course in coursesArray) FlatButton(
                                          padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                                          shape: Border(
                                              bottom: BorderSide(color: studycloudblue, width: 1),
                                            ),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(course, style: TextStyle(fontSize: 20, fontFamily: 'Alegreya'), textAlign: TextAlign.left,),
                                          ),
                                          onPressed: () {
                                            Clipboard.setData(new ClipboardData(text: course));
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 32, 16, 8),
                  child: Text('Search for the course you need help in. Then, use the information listed in order to contact a helper.',
                    style: TextStyle(color: Colors.black, fontFamily: 'Alegreya', fontSize: 20), textAlign: TextAlign.center,),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(error, style: TextStyle(color: studycloudred, fontSize: 15, fontFamily: 'Alegreya'), textAlign: TextAlign.center,),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: TextField(
                          controller: searchBar,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: studycloudblue
                                  )
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: studycloudblue)
                              ),
                              hintText: 'Course Name',
                              contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                              isDense: true
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(8),
                      color: studycloudblue,
                      child: Text('Search Local', style: TextStyle(color: Colors.white, fontFamily: 'Alegreya', fontSize: 20),),
                      onPressed: () {
                        setState(() {
                          error = "";
                        });
                        searchLocal(searchBar.text.toLowerCase().trim());
                      },
                    ),
                    Container(
                      width: 8,
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(8),
                      color: studycloudblue,
                      child: Text('Search Cloud', style: TextStyle(color: Colors.white, fontFamily: 'Alegreya', fontSize: 20),),
                      onPressed: () {
                        setState(() {
                          error = "";
                        });
                        searchCloud(searchBar.text.toLowerCase().trim());
                      },
                    ),
                    Container(
                      width: 16,
                    )
                  ],
                ),
                if (helpersArray.length >= 1) Container(
                  height: 1000,
                  padding: EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      for(String helper in helpersArray) StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance.collection("Users").doc(helper).snapshots(),
                        builder: (context, querySnapshot) {
                          if(!querySnapshot.hasData) {
                            return Center(
                              child: Container(
                                child: Text('Loading Data... One Moment Please...', style: TextStyle(color: studycloudred, fontFamily: 'Alegreya', fontSize: 20), textAlign: TextAlign.center,),
                              ),
                            );
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(16, 32, 16, 8),
                                  child: Text(querySnapshot.data.get('Name'), style: TextStyle(fontFamily: 'Alegreya', fontSize: 20, color: Colors.black),),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                                  child: Text('${querySnapshot.data.get('Grade')} at ${schoolsArray[schoolCodesArray.indexOf(querySnapshot.data.get('School'))]}', style: TextStyle(fontFamily: 'Alegreya', fontSize: 15, color: Colors.blueGrey),),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                                  child: Text('Email: ${querySnapshot.data.get('email')}', style: TextStyle(fontFamily: 'Alegreya', fontSize: 15, color: Colors.blueGrey),),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: Text('Phone Number: ${querySnapshot.data.get('#')}', style: TextStyle(fontFamily: 'Alegreya', fontSize: 15, color: Colors.blueGrey),),
                                ),
                              ],
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
                if (helpersArray.length == 0) Container(
                  height: 1000,
                ),
                footer(),
              ],
            );
          } else {
            return Center(
              child: Container(
                child: Text('Please log in!', style: TextStyle(color: studycloudred, fontFamily: 'Alegreya', fontSize: 20), textAlign: TextAlign.center,),
              ),
            );
          }
        },
      )
    );
  }
}