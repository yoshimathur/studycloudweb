import 'package:flutter/material.dart';
import 'package:study_cloud/schoolCodesRef.dart';
import 'dart:math';

import 'profile.dart';
import 'main.dart';
import 'footer.dart';
import 'schoolCodesRef.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class logIn extends StatefulWidget {
  @override
  _logInState createState() => _logInState();
}

class _logInState extends State<logIn> {

  var initSingUp = 1.0;
  var signUp = 0.0;
  bool editSingUp = true;
  var signUpButton = 1.0;
  var enterName = 0.0;
  bool editEnterName = true;
  var enterNameButton = 1.0;
  var selectGrade = 0.0;
  var selectGradeButtons = 1.0;
  var selectCourses = 0.0;
  List<String> displayedCoursesArray = mathCourses;
  List<String> selectedCoursesArray = [];
  List<String> cleanedSelectedCoursesArray = [];

  final logInEmailTextController = TextEditingController();
  final logInPasswordTextController = TextEditingController();
  final signUpEmailTextController = TextEditingController();
  final signUpPasswordTextController = TextEditingController();
  final signUpConfirmPasswordTextController = TextEditingController();
  final signUpCodeTextController = TextEditingController();
  final enterNameTextController = TextEditingController();
  final enterNumberTextController = TextEditingController();

  String logInError = "";
  catchLogInError(String error) {
    setState(() {
      logInError = error;
      logInEmailTextController.clear();
      logInPasswordTextController.clear();
    });
  }

  //sign up
  String signUpError = "";
  catchSingUpError(String error) {
    setState(() {
      signUpError = error;
      signUpEmailTextController.clear();
      signUpPasswordTextController.clear();
      signUpConfirmPasswordTextController.clear();
      signUpCodeTextController.clear();
    });
  }
  signUpSuccess() {
    setState(() {
      enterName = 1.0;
      editSingUp = false;
      signUpButton = 0.0;
      signUp = 0.25;
    });
  }

  //name and number
  String enterNameError = "";
  catchEnterNameError(String error) {
    setState(() {
      enterNameError = error;
    });
  }
  enterNameSuccess(String uid, String email, String school, String number, int tag) {
    //getting the district
    int codeIndex = schoolCodesArray.indexOf(school);
    String schoolName = schoolsArray[codeIndex];
    int splice = schoolName.indexOf(",");
    String districtName = schoolName.substring(splice, schoolName.length);
    List<String> districtSchools = schoolsArray.where((school) => school.toLowerCase().trim().contains(districtName.toLowerCase().trim())).toSet().toList();
    int district = schoolsArray.indexOf(districtSchools.first);

    //saving data
    FirebaseFirestore.instance.collection('Users').doc(uid).set({"Name": enterNameTextController.text, "email": email, "School": school, "#": number, "Tag": tag, "District": district})
        .then((value) => enterNameTransition())
        .catchError((error) => catchEnterNameError(error.toString()));
  }
  enterNameTransition(){
    setState(() {
      selectGrade = 1;
      enterName = 0.25;
      editEnterName = false;
      enterNameButton = 0.0;
    });
  }

  //grade selection
  gradeSelect(String uid, String grade, bool helper) {
    FirebaseFirestore.instance.collection("Users").doc(uid).update({"Grade": grade, "Helper" : helper})
      .then((value) => selectGradeTransition())
      .catchError((error) => print(error.toString()));
  }
  selectGradeTransition() {
    setState(() {
      selectCourses = 1;
      selectGrade = 0.25;
      selectGradeButtons = 0;
    });
  }

  //courses selection
  Widget subjectButtons(int i) {

    final buttonStyle = TextStyle(fontSize: 20, fontFamily: 'ALegreya', color: Colors.black,);

    switch(i) {
      case 1: {
        return RaisedButton(
          color: studycloudblue,
          splashColor: studycloudyellow,
          child: Text("Math", style: buttonStyle ),
          onPressed: () {
            setState(() {
              displayedCoursesArray = mathCourses;
            });
          },
        );
      }
      break;
      case 3: {
        return RaisedButton(
          color: studycloudblue,
          splashColor: studycloudyellow,
          child: Text("Language Arts", style: buttonStyle ),
          onPressed: () {
            setState(() {
              displayedCoursesArray = lalCourses;
            });
          },
        );
      }
      break;
      case 5: {
        return RaisedButton(
          color: studycloudblue,
          splashColor: studycloudyellow,
          child: Text("Science", style: buttonStyle ),
          onPressed: () {
            setState(() {
              displayedCoursesArray = scienceCourses;
            });
          },
        );
      }
      break;
      case 7: {
        return RaisedButton(
          color: studycloudblue,
          splashColor: studycloudyellow,
          child: Text("History", style: buttonStyle ),
          onPressed: () {
            setState(() {
              displayedCoursesArray = historyCourses;
            });
          },
        );
      }
      break;
      case 9: {
        return RaisedButton(
          color: studycloudblue,
          splashColor: studycloudyellow,
          child: Text("Spanish", style: buttonStyle ),
          onPressed: () {
            setState(() {
              displayedCoursesArray = spanishCourses;
            });
          },
        );
      }
      break;
      case 11: {
        return RaisedButton(
          color: studycloudblue,
          splashColor: studycloudyellow,
          child: Text("French", style: buttonStyle ),
          onPressed: () {
            setState(() {
              displayedCoursesArray = frenchCourses;
            });
          },
        );
      }
      break;
      case 13: {
        return RaisedButton(
          color: studycloudblue,
          splashColor: studycloudyellow,
          child: Text("Italian", style: buttonStyle ),
          onPressed: () {
            setState(() {
              displayedCoursesArray = italianCourses;
            });
          },
        );
      }
      break;
      case 15: {
        return RaisedButton(
          color: studycloudblue,
          splashColor: studycloudyellow,
          child: Text("German", style: buttonStyle ),
          onPressed: () {
            setState(() {
              displayedCoursesArray = germanCourses;
            });
          },
        );
      }
      break;
      case 17: {
        return RaisedButton(
          color: studycloudblue,
          splashColor: studycloudyellow,
          child: Text("Japanese", style: buttonStyle ),
          onPressed: () {
            setState(() {
              displayedCoursesArray = japaneseCourses;
            });
          },
        );
      }
      break;
      case 19: {
        return RaisedButton(
          color: studycloudblue,
          splashColor: studycloudyellow,
          child: Text("Chinese", style: buttonStyle ),
          onPressed: () {
            setState(() {
              displayedCoursesArray = chineseCourses;
            });
          },
        );
      }
      break;
      case 21: {
        return RaisedButton(
          color: studycloudblue,
          splashColor: studycloudyellow,
          child: Text("AP Electives", style: buttonStyle ),
          onPressed: () {
            setState(() {
              displayedCoursesArray = electiveCourses;
            });
          },
        );
      }
      break;
    }
  }
  saveCourses(String uid) {
    //rewriting courses array in indices
    List<int> indexedCoursesArray = [];
    for (var course in selectedCoursesArray) {
      indexedCoursesArray.add(coursesArray.indexOf(course));
    }
    FirebaseFirestore.instance.collection("Users").doc(uid).update({"Courses": indexedCoursesArray})
      .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => profile())))
      .catchError((error) => print(error.toString()));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Cloud · Log In', style: TextStyle(fontSize: 30, fontFamily: 'Alegreya'),),
        backgroundColor: studycloudred,
        centerTitle: false,
      ),
      drawer: menu(),
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(16, 50, 16, 16),
                    child: TextField(
                      controller: logInEmailTextController,
                      decoration: InputDecoration(
                          enabledBorder: new OutlineInputBorder(
                              borderSide: BorderSide(color: studycloudblue)
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: studycloudblue)
                          ),
                          contentPadding: EdgeInsets.all(16),
                          isDense: true,
                          hintText: 'Email'
                      ),
                    )
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: TextField(
                      controller: logInPasswordTextController,
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: new OutlineInputBorder(
                              borderSide: BorderSide(color: studycloudblue)
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: studycloudblue)
                          ),
                          contentPadding: EdgeInsets.all(16),
                          isDense: true,
                          hintText: 'Password'
                      ),
                    )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(logInError, style: TextStyle(fontSize: 15, color: studycloudred, fontStyle: FontStyle.italic, fontFamily: 'Alegreya'), textAlign: TextAlign.center,),
                ),
                FlatButton(
                  padding: EdgeInsets.all(16),
                  child: Text('Log In', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: studycloudblue, fontFamily: 'Alegreya'),),
                  onPressed: () {
                    if (logInEmailTextController.text.trim() == ''){
                      setState(() {
                        logInError = 'Please fill out all the fields!';
                        print('Please fill out all the fields');
                      });
                    } else if(logInPasswordTextController.text.trim() == ''){
                      setState(() {
                        logInError = 'Please fill out all the fields!';
                        print('Please fill out all the fields');
                      });
                    } else {
                      FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: logInEmailTextController.text,
                          password: logInPasswordTextController.text)
                          .then((_) => Navigator.push(context, MaterialPageRoute(builder: (context) => profile())))
                          .catchError((error) {catchLogInError(error.toString());});
                    }
                  },
                ),

                //sign up button
                Opacity(
                  opacity: initSingUp,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: Text('Don\'t have an account?', style: TextStyle(fontFamily: 'Alegreya'),),
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(16),
                        child: Text('Sign Up', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: studycloudblue, fontFamily: 'Alegreya'),),
                        onPressed: () {
                          setState(() {
                            signUp = 1;
                            initSingUp = 0.0;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                //signing up part 1 - authentication and school
                Opacity(
                  opacity: signUp,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Text('Do not leave this page until you are completely done signing up!', style: TextStyle(fontFamily: 'Alegreya', fontSize: 20, color: studycloudred), textAlign: TextAlign.center,),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: TextField(
                          controller: signUpEmailTextController,
                          enabled: editSingUp,
                          decoration: InputDecoration(
                              enabledBorder: new OutlineInputBorder(
                                  borderSide: BorderSide(color: studycloudblue)
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: studycloudblue)
                              ),
                              contentPadding: EdgeInsets.all(16),
                              isDense: true,
                              hintText: "Email"
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: TextField(
                          controller: signUpPasswordTextController,
                          enabled: editSingUp,
                          obscureText: true,
                          decoration: InputDecoration(
                              enabledBorder: new OutlineInputBorder(
                                  borderSide: BorderSide(color: studycloudblue)
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: studycloudblue)
                              ),
                              contentPadding: EdgeInsets.all(16),
                              isDense: true,
                              hintText: "Password"
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: TextField(
                          controller: signUpConfirmPasswordTextController,
                          enabled: editSingUp,
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: new OutlineInputBorder(
                                borderSide: BorderSide(color: studycloudblue)
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: studycloudblue)
                            ),
                            contentPadding: EdgeInsets.all(16),
                            isDense: true,
                            hintText: "Confirm Password",
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                              child: TextField(
                                controller: signUpCodeTextController,
                                enabled: editSingUp,
                                decoration: InputDecoration(
                                    enabledBorder: new OutlineInputBorder(
                                        borderSide: BorderSide(color: studycloudblue)
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: studycloudblue)
                                    ),
                                    contentPadding: EdgeInsets.all(16),
                                    isDense: true,
                                    hintText: "School Code"
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 32, 8),
                            child: IconButton(
                              icon: Icon(Icons.info_outline),
                              color: studycloudblue,
                              onPressed: () {

                                //creating a pop up for the schools
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
                                          codesRef()
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Text(signUpError, style: TextStyle(fontSize: 15, fontFamily: 'Alegreya', fontStyle: FontStyle.italic, color: studycloudred), textAlign: TextAlign.center,),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: FlatButton(
                          child: Text("View Terms and Conditions", style: TextStyle(fontSize: 20, fontFamily: 'Alegreya', color: Colors.black), textAlign: TextAlign.center,),
                          onPressed: () {

                            //viewing the terms and conditions
                            showDialog(context: context, builder: (BuildContext context) {
                              return Dialog (
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        icon: Icon(Icons.clear),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(16),
                                            child: Text(terms, style: TextStyle(fontSize: 20, fontFamily: 'Alegreya', color: Colors.black), textAlign: TextAlign.left,),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                          },
                        ),
                      ),
                      Opacity(
                        opacity: signUpButton,
                        child: FlatButton(
                          padding: EdgeInsets.all(16),
                          child: Text('Sign Up', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Alegreya', color: studycloudblue),),
                          onPressed: () {
                            if (signUpEmailTextController.text == "") {
                              setState(() {
                                signUpError = 'Please fill out all the fields!';
                              });
                            } else if(signUpPasswordTextController.text == ""){
                              setState(() {
                                signUpError = 'Please fill out all the fields!';
                              });
                            } else if(signUpConfirmPasswordTextController.text == ""){
                              setState(() {
                                signUpError = 'Please fill out all the fields!';
                              });
                            } else if(signUpCodeTextController.text == ""){
                              setState(() {
                                signUpError = 'Please fill out all the fields!';
                              });
                            } else if(RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(signUpEmailTextController.text) == false) {
                              setState(() {
                                signUpError = 'Please enter a valid email!';
                              });
                            } else if(RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$").hasMatch(signUpPasswordTextController.text) == false) {
                              setState(() {
                                signUpError = 'Create a stronger password with at least 8 characters, a capital letter, and a number!';
                              });
                            } else if(signUpPasswordTextController.text != signUpConfirmPasswordTextController.text){
                              setState(() {
                                signUpError = 'Passwords do not match!';
                              });
                            } else if(schoolCodesArray.contains(signUpCodeTextController.text.toString()) == false){
                              setState(() {
                                signUpError = 'Please enter a valid school code!';
                              });
                            } else {
                              FirebaseAuth.instance.createUserWithEmailAndPassword(email: signUpEmailTextController.text.trim(), password: signUpPasswordTextController.text.trim())
                                  .then((value) => signUpSuccess())
                                  .catchError((error) => {catchSingUpError(error.toString())});
                            }
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text("By clicking sign up, you automatically agree to the Terms and Conditions.",
                            style: TextStyle(fontSize: 20, fontFamily: 'Alegreya', fontStyle: FontStyle.italic, color: studycloudred), textAlign: TextAlign.center,),
                      )
                    ],
                  ),
                ),

                //taking the name and number of the user
                Opacity(
                  opacity: enterName,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 50, 16, 16),
                        child: Text('Thank you for signing up for us! We need to ask you a few more questions to finish setting up your profile. Please fill out your name and number correctly. This cannot be changed later!!', style: TextStyle(fontSize: 20, fontFamily: 'Alegreya', color: studycloudred), textAlign: TextAlign.center,),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: TextField(
                          controller: enterNameTextController,
                          decoration: InputDecoration(
                              enabled: editEnterName,
                              border: new OutlineInputBorder(
                                  borderSide: BorderSide(color: studycloudblue)
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: studycloudblue)
                              ),
                              contentPadding: EdgeInsets.all(16),
                              isDense: true,
                              hintText: 'Full Name'
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                        child: TextField(
                          controller: enterNumberTextController,
                          decoration: InputDecoration(
                              enabled: editEnterName,
                              border: new OutlineInputBorder(
                                  borderSide: BorderSide(color: studycloudblue)
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: studycloudblue)
                              ),
                              contentPadding: EdgeInsets.all(16),
                              isDense: true,
                              hintText: 'Phone Number (Optional)'
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(enterNameError, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15, color: studycloudred, fontFamily: 'Alegreya'), textAlign: TextAlign.center,),
                      ),
                      Opacity(
                        opacity: enterNameButton,
                        child: FlatButton(
                          padding: EdgeInsets.all(16),
                          child: Text('Save', style: TextStyle(fontSize: 20, fontFamily: 'Alegreya', fontWeight: FontWeight.bold, color: studycloudblue),),
                          onPressed: () async {
                            if (enterNameTextController.text == "") {
                              setState(() {
                                enterNameError = 'Please fill out all infromation!';
                              });
                            } else {
                              final user = await FirebaseAuth.instance.currentUser();
                              final school = signUpCodeTextController.text;
                              final number = enterNumberTextController.text;
                              final tag = Random().nextInt(1001);
                              String uid = user.uid;
                              String email = user.email;
                              UserUpdateInfo userUpdateInfo = UserUpdateInfo();
                              userUpdateInfo.displayName = enterNameTextController.text.trim();
                              user.updateProfile(userUpdateInfo);
                              enterNameSuccess(uid, email, school, number, tag);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                //selecting grade
                Opacity(
                  opacity: selectGrade,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 50, 16, 16),
                        child: Text('Please select the grade that you are in. If you are not in high school, then select underclassman. Select correctly!!', style: TextStyle(fontSize: 20, fontFamily: 'Alegreya', color: studycloudred), textAlign: TextAlign.center,),
                      ),
                      Opacity(
                        opacity: selectGradeButtons,
                        child: Column(
                          children: [
                            Container(
                              width: 300,
                              padding: EdgeInsets.all(16),
                              child: RaisedButton(
                                color: studycloudblue,
                                child: Text('Underclassman', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Alegreya', color: Colors.black), textAlign: TextAlign.center,),
                                onPressed: () async{
                                  final user = await FirebaseAuth.instance.currentUser();
                                  String uid = user.uid;
                                  gradeSelect(uid, 'Underclassman', false);
                                },
                              ),
                            ),
                            Container(
                              width: 300,
                              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: RaisedButton(
                                color: studycloudblue,
                                child: Text('Freshman', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Alegreya', color: Colors.black), textAlign: TextAlign.center,),
                                onPressed: () async{
                                  final user = await FirebaseAuth.instance.currentUser();
                                  String uid = user.uid;
                                  gradeSelect(uid, 'Freshman', true);
                                },
                              ),
                            ),
                            Container(
                              width: 300,
                              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: RaisedButton(
                                color: studycloudblue,
                                child: Text('Sophomore', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Alegreya', color: Colors.black), textAlign: TextAlign.center,),
                                onPressed: () async{
                                  final user = await FirebaseAuth.instance.currentUser();
                                  String uid = user.uid;
                                  gradeSelect(uid, 'Sophomore', true);
                                },
                              ),
                            ),
                            Container(
                              width: 300,
                              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: RaisedButton(
                                color: studycloudblue,
                                child: Text('Junior', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Alegreya', color: Colors.black), textAlign: TextAlign.center,),
                                onPressed: () async{
                                  final user = await FirebaseAuth.instance.currentUser();
                                  String uid = user.uid;
                                  gradeSelect(uid, 'Junior', true);
                                },
                              ),
                            ),
                            Container(
                              width: 300,
                              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: RaisedButton(
                                color: studycloudblue,
                                child: Text('Senior', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Alegreya', color: Colors.black), textAlign: TextAlign.center,),
                                onPressed: () async{
                                  final user = await FirebaseAuth.instance.currentUser();
                                  String uid = user.uid;
                                  gradeSelect(uid, 'Senior', true);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //selecting courses
                Opacity(
                  opacity: selectCourses,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text('Select all, including lower level, courses that you are comfortable teaching. For example, if you are comfortable with AP Biology, also select Biology and Honors Biology.',
                          style: TextStyle(fontSize: 20, fontFamily: 'Alegreya', color: studycloudred), textAlign: TextAlign.center,),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              height: 600,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                                    height: 50,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        for (var i = 1; i <= 21; i++) Container(
                                          width: (i%2 == 0) ? 16 : 150,
                                          child: subjectButtons(i),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: studycloudblue, width: 3,),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    height: 500,
                                    padding: EdgeInsets.all(16),
                                    child: ListView(
                                      children: [
                                        for(var course in displayedCoursesArray) Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: studycloudblue,
                                                width: 1,
                                              )
                                            )
                                          ),
                                          width: 250,
                                          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                          child: FlatButton(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(course, style: TextStyle(fontSize: 20, fontFamily: 'Alegreya', color: Colors.black), textAlign: TextAlign.left,),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                print(course);
                                                if(selectedCoursesArray.contains(course)) {
                                                  return;
                                                } else {
                                                  selectedCoursesArray.add(course);
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              height: 600,
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    padding: EdgeInsets.fromLTRB(0, 8, 16, 8),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Text('Your courses.', style: TextStyle(fontSize: 20, fontFamily: 'Alegreya', fontWeight: FontWeight.bold, color: studycloudblue), textAlign: TextAlign.center,),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: studycloudblue, width: 3,),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    height: 500,
                                    padding: EdgeInsets.all(16),
                                    child: ListView(
                                      children: [
                                        for (var selectedCourse in selectedCoursesArray) Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                    color: studycloudblue,
                                                    width: 1,
                                                  )
                                              )
                                          ),
                                          width: 250,
                                          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                          child: FlatButton(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(selectedCourse, style: TextStyle(fontSize: 20, fontFamily: 'Alegreya', color: Colors.black), textAlign: TextAlign.center,),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                selectedCoursesArray.remove(selectedCourse);
                                                print(selectedCourse);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(16),
                        child: Text('Save', style: TextStyle(fontSize: 20, fontFamily: 'Alegreya', fontWeight: FontWeight.bold, color: studycloudblue),),
                        onPressed: () async {
                          final user = await FirebaseAuth.instance.currentUser();
                          String uid = user.uid;
                          saveCourses(uid);
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50
                ),
                footer()
              ],
            ),
          )
        ],
      ),
    );
  }
}