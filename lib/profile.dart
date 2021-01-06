import 'package:flutter/material.dart';

import 'main.dart';
import 'home.dart';
import 'footer.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile>{

  bool addingCourses = false;
  String addCoursesText = 'Add Courses';
  double addCourses = 0.0;
  String deletedCourse = '';
  int deletedCourseIndex = -1;
  String addedCourse = '';
  int addedCourseIndex = -1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Cloud · Profile', style: TextStyle(fontSize: 30, fontFamily: 'Alegreya'),),
        backgroundColor: studycloudred,
        centerTitle: false,
      ),
      drawer: menu(),
      body: FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection("Users").doc(snapshot.data.uid).snapshots(),
              builder: (context, querySnapshot) {
                if(!querySnapshot.hasData || schoolCodesArray.length == 0 || schoolsArray.length == 0) return Center(
                  child: Container(
                    child: Text('Loading Data... One Moment Please...', style: TextStyle(color: studycloudred, fontFamily: 'Alegreya', fontSize: 20), textAlign: TextAlign.center,),
                  ),
                );
                print(snapshot.data.uid);

                //data was found in the query
                final String name = querySnapshot.data.get("Name");
                final String grade = querySnapshot.data.get("Grade");
                final String school = schoolsArray[schoolCodesArray.indexOf(querySnapshot.data.get("School"))];
                final List<dynamic> userCourses = querySnapshot.data.get("Courses");

                return ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          color: studycloudblue,
                          child: Text(addCoursesText, style: TextStyle(color: Colors.white, fontFamily: 'Alegreya', fontSize: 20), textAlign: TextAlign.center,),
                          onPressed: () {
                            setState(() {
                              if (addCourses == 0.0) {
                                addingCourses = true;
                                addCourses = 1.0;
                                addCoursesText = 'Hide Courses';
                                return;
                              } else if(addCourses == 1.0) {
                                addingCourses = false;
                                addCourses = 0.0;
                                addCoursesText = 'Add Courses';
                                return;
                              }
                            });
                          },
                        ),
                        Container(
                          width: 10,
                        ),
                        FlatButton(
                          color: studycloudred,
                          child: Text('Log Out', style: TextStyle(color: Colors.white, fontFamily: 'Alegreya', fontSize: 20), textAlign: TextAlign.center,),
                          onPressed: () async{
                            await FirebaseAuth.instance.signOut().then((value) => {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => home()))
                            });
                          },
                        ),
                        Container(
                          width: 10,
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Text(name, style: TextStyle(color: studycloudred, fontSize: 30, fontFamily: 'Alegreya'), textAlign: TextAlign.left,),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Text(grade, style: TextStyle(fontSize: 20, fontFamily: 'Alegreya'), textAlign: TextAlign.left,),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Text(school, style: TextStyle(fontSize: 20, fontFamily: 'Alegreya'), textAlign: TextAlign.left,),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Text('Your Courses: (tap to remove a course)', style: TextStyle(fontSize: 20, fontFamily: 'Alegreya'), textAlign: TextAlign.left,),
                          ),
                        ),
                        if (addingCourses) Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Text('Tap to add a course!', style: TextStyle(color: studycloudred, fontSize: 20, fontFamily: 'Alegreya'), textAlign: TextAlign.left,),
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: studycloudblue, width: 3),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              padding: EdgeInsets.all(16),
                              height: 500,
                              child: ListView(
                                children: [
                                  for (var courseIndex in userCourses) FlatButton(
                                    shape: Border(
                                      bottom: BorderSide(color: studycloudblue, width: 1)
                                    ),
                                    padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(coursesArray[courseIndex], style: TextStyle(fontSize: 20, fontFamily: 'Alegreya'), textAlign: TextAlign.center,),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        deletedCourse = coursesArray[courseIndex];
                                        deletedCourseIndex = courseIndex;
                                        showDialog(context: context, builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Remove Course", style: TextStyle(fontFamily: 'Alegreya'),),
                                            content: Text("Are you sure you want to remove ${deletedCourse}?", style: TextStyle(fontFamily: 'Alegreya')),
                                            actions: [
                                              FlatButton(
                                                child: Text("Cancel", style: TextStyle(fontFamily: 'Alegreya', color: studycloudblue), textAlign: TextAlign.center,),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              FlatButton(
                                                child: Text("Confirm", style: TextStyle(fontFamily: 'Alegreya', color: studycloudred), textAlign: TextAlign.center,),
                                                onPressed: () async {
                                                  final user = await FirebaseAuth.instance.currentUser();
                                                  final uid = user.uid;
                                                  FirebaseFirestore.instance.collection("Users").doc(uid).update({"Courses": FieldValue.arrayRemove([deletedCourseIndex])})
                                                  .then((value) => Navigator.of(context).pop());
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (addingCourses) Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Container (
                              decoration: BoxDecoration(
                                border: Border.all(color: studycloudblue, width: 3),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              padding: EdgeInsets.all(16),
                              height: 500,
                              child: ListView (
                                children: [
                                  for(var course in coursesArray) FlatButton(
                                    shape: Border(
                                        bottom: BorderSide(color: studycloudblue, width: 1)
                                    ),
                                    padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(course, style: TextStyle(fontSize: 20, fontFamily: 'Alegreya'), textAlign: TextAlign.center,),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        addedCourse = course;
                                        addedCourseIndex = coursesArray.indexOf(course);
                                        showDialog(context: context, builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Add Course", style: TextStyle(fontFamily: 'Alegreya'),),
                                            content: Text("Are you sure you want to add ${addedCourse}?", style: TextStyle(fontFamily: 'Alegreya'),),
                                            actions: [
                                              FlatButton(
                                                child: Text("Cancel", style: TextStyle(fontFamily: 'Alegreya', color: studycloudblue), textAlign: TextAlign.center,),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              FlatButton(
                                                child: Text("Confirm", style: TextStyle(fontFamily: 'Alegreya', color: studycloudred), textAlign: TextAlign.center,),
                                                onPressed: () async {
                                                  final user = await FirebaseAuth.instance.currentUser();
                                                  final uid = user.uid;
                                                  FirebaseFirestore.instance.collection("Users").doc(uid).update({"Courses": FieldValue.arrayUnion([addedCourseIndex])})
                                                      .then((value) => Navigator.of(context).pop());
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 50,
                    ),
                    footer(),
                  ],
                );
              },
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