import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'reqHelp.dart';
import 'home.dart';
import 'logIn.dart';
import 'contactUs.dart';
import 'support.dart';
import 'profile.dart';

import 'package:csv/csv.dart';


// Constants for the project are listed here
final studycloudred = Color.fromRGBO(180, 29, 0, 1);
final studycloudyellow = Color.fromRGBO(255, 222, 57, 1);
final studycloudblue = Color.fromRGBO(90, 200, 250, 1);

//course arrays
final mathCourses = ["Algebra 1", "Honors Algebra 1", "Geometry", "Honors Geometry", "Algebra 2", "Honors Algebra 2", "Pre-Calculus", "Honors Pre-Calculus", "Calculus AB", "Honors Calculus AB", "AP Calculus AB", "Calculus BC", "Honors Calculus BC", "AP Calculus BC"];
final lalCourses = ["Language Arts and Literature 1", "Honors Language Arts and Literature 1", "Language Arts and Literature 2", "Honors Language Arts and Literature 2", "Language Arts and Literature 3", "Honors Language Arts and Literature 3", "AP English Language and Composition", "Language Arts and Literature 4", "Honors Language Arts and Literature 4", "AP English Literature and Composition"];
final scienceCourses = ["Biology", "Honors Biology", "AP Biology", "Chemistry", "Honors Chemistry", "AP Chemistry", "Physics 1", "Honors Physics 1", "AP Physics 1", "AP Physics 2", "AP Physics C Mechanics", "AP Physics C Electricity and Magnetism"];
final historyCourses = ["World History", "Honors World History", "AP World History: Modern", "U.S History", "Honors U.S History", "AP U.S History", "AP U.S Government and Politics"];
final spanishCourses = ["Spanish 1", "Honors Spanish 1", "Spanish 2", "Honors Spanish 2", "Spanish 3", "Honors Spanish 3", "Spanish 4", "Honors Spanish 4", "AP Spanish"];
final frenchCourses = ["French 1", "Honors French 1", "French 2", "Honors French 2", "French 3", "Honors French 3", "French 4", "Honors French 4", "AP French"];
final italianCourses = ["Italian 1", "Honors Italian 1", "Italian 2", "Honors Italian 2", "Italian 3", "Honors Italian 3", "Italian 4", "Honors Italian 4", "AP Italian"];
final germanCourses = ["German 1", "Honors German 1", "German 2", "Honors German 2", "German 3", "Honors German 3", "German 4", "Honors German 4", "AP German"];
final japaneseCourses = ["Japanese 1", "Honors Japanese 1", "Japanese 2", "Honors Japanese 2", "Japanese 3", "Honors Japanese 3", "Japanese 4", "Honors Japanese 4", "AP Japanese"];
final chineseCourses = ["Chinese 1", "Honors Chinese 1", "Chinese 2", "Honors Chinese 2", "Chinese 3", "Honors Chinese 3", "Chinese 4", "Honors Chinese 4", "AP Chinese"];
final latinCourses = [ "Latin 1", "Honors Latin 1", "Latin 2", "Honors Latin 2", "Latin 3", "Honors Latin 3", "Latin 4", "Honors Latin 4", "AP Latin"];
final electiveCourses = [ "AP Computer Science A", "AP Computer Science Principles", "AP Statistics", "AP Art History", "AP Music Theory", "AP Comparative Government and Politics", "AP European History", "AP Human Geography", "AP Macroeconomics", "AP Microeconomics", "AP Psychology"];
final coursesArray = mathCourses + lalCourses + scienceCourses + historyCourses + spanishCourses + frenchCourses + italianCourses + germanCourses + japaneseCourses + chineseCourses + latinCourses + electiveCourses;

//about us description
final aboutUsDescription = Text('About Us\n\nStudy Cloud is a brand new virtual platform made for students. Imagine having a tutor that has had the same teachers as you, been a part of the same schooling system as you too, and knows exactly what you\'re going through. Now, with the click of a button, finding this type of help is possible. By connecting upperclassmen with underclassmen in need of help, both groups are able to reap extraordinary benefits and maximize their educations. Underclassmen directly receive the help they need, and by helping others, the upperclassmen help themselves as well. This type of tutoring has never been seen before on a large and virtual platform, but now with Study Cloud, students can get help from the people that were in the same shoes as them not so long ago.',
  style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Alegreya'),);

//schools and codes
final List<String> schoolsArray = [];
loadSchools() async {
  final schoolsCSV = await rootBundle.loadString('assets/schoolsDart.csv');
  List<List<dynamic>> schoolsTable = CsvToListConverter().convert(schoolsCSV);
  for(var schools in schoolsTable){
    for(var school in schools) {
      schoolsArray.add(school);
    }
  }
}

final List<String> schoolCodesArray = [];
loadCodes() async{
  final codesCSV = await rootBundle.loadString('assets/codesDart.csv');
  List<List<dynamic>> codesTable = CsvToListConverter().convert(codesCSV);
  for(var codes in codesTable){
    for(var code in codes){
      schoolCodesArray.add(code);
    }
  }
}


void main() => runApp(studycloud());

//this initializes the first view - home screen
class studycloud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Study Cloud',
      home: home(),
    );
  }
}

//constant widget created for the drop down menu
class menu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Home', style: TextStyle(fontFamily: 'Alegreya', color: studycloudred),),
            contentPadding: EdgeInsets.fromLTRB(16, 20, 0, 0),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => home()
                  )
              );
            },
          ),
          ListTile(
            title: Text('Contact Us', style: TextStyle(fontFamily: 'Alegreya',),),
            contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => contactUs()
                ),
              );
            },
          ),
          ListTile(
            title: Text('Support', style: TextStyle(fontFamily: 'Alegreya'),),
            contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => support()
                  )
              );
            },
          ),
          ListTile(
              title: Text('Profile', style: TextStyle(fontFamily: 'Alegreya', color: studycloudblue,)),
              contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => profile()
                    )
                );
              }
          ),
          ListTile(
            title: Text('Request Help', style: TextStyle(fontFamily: 'Alegreya', color: studycloudblue),),
            contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => requestHelp()
                )
              );
            },
          ),
          ListTile(
            title: Text('Log In', style: TextStyle(fontFamily: 'Alegreya', color: studycloudblue),),
            contentPadding: EdgeInsets.fromLTRB(16, 50, 0, 0),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => logIn()
                  )
              );
            },
          )
        ],
      ),
    );
  }
}

String terms = '''
Terms and Conditions

Welcome to Study Cloud!

These terms and conditions govern your use of Study Cloud and provide information about the Study Cloud services below. By creating a Study Cloud account, you automatically agree to these terms. 

Study Cloud is a Hills Industries product. These terms establish the relationship between you and other users, between you and Study Cloud, and between you and Hills Industries. 

Any disputes or conflicts that arise between you and us will be settled through the use of an arbitrator. 


Study Cloud Services

We agree to provide you with the Study Cloud Service. The Service includes all of the Study Cloud products, applications, features, services, and technology that we provide to further the Study Cloud mission: advancing education for high school students while offering a platform to receive monetary payments as per the discretion of other users. 

  - Offering the opportunity for students to receive the educational help they need from peers and older students. Study Cloud aims to connect students that are in need of educational help with other students that have been in the same situation as them. By providing students with the platform and opportunity to receive help from students that have had the same classes, teachers and material, Study Cloud looks to foster a better educational environment where students can excel. 

  - Offering the opportunity for students to receive monetary payment for helping a student as per the discretion of the students being helped. When a student reaches out for help to a different student, all monetary transactions are decided and handled between the helper and the beneficiary. Any form of communication between the helper and beneficiary must also be conducted outside of the app, but the information needed to initiate communication will be displayed through Study Cloud. At any given moment, the helper is allowed to refuse his service for any reason of his or her choosing. 

  - Providing students with the necessary means to develop their education. Study Cloud aims to provide each and every student with the facilities in order to receive the best grades. If a student comes into conflict with any integrity of the school between them and the school, the school is free to punish them accordingly and justly.


Your Commitments

In return for our commitments to provide you with the Study Cloud Service, we ask for you to make the commitments listed below to us. Any violation of the commitments below can result in disciplinary action, restriction from the app and/or legal penalties. 

Who can use Study Cloud. Study Cloud is open to students throughout high school. Students younger than the required age that are planning on using the app must provide a legal guardian’s phone number. There are a few restrictions to becoming a user. 

  -You must be at least 13 years old.
  -You must not have a previously disabled account. 
  -You must not be a high school graduate. 
  -You must not have any prior conflict with the school you are attending. 
  -You must not have any prior legal charges or convictions. 

How you can’t use Study Cloud. In order to create a safe environment that can properly foster the educational growth of students, it is important that you and all users follow a set of guidelines. Any violation of these guidelines can result in disciplinary action, restriction from the app and/or legal penalties. 

  - You can’t impersonate others or provide incorrect information. Study Cloud provides a platform for students to interact with others, and this is only made possible when the information provided is accurate. Therefore, you must agree to provide your full legal name, a reachable phone number and email, a correct and updated school, and an accurate course selection. Any information that is proven to be incorrect or misleading will result in your immediate restriction.

  - You can’t abuse the information provided to you. Study Cloud creates a platform where users can find information necessary to communicate with other students in order to find help in any educational field. Any abuse of the information provided will result in your immediate restriction of the app and can lead to further legal implications. Using a number or email in order to communicate in anything out of the bounds of necessary assistance is deemed abuse of the information if a complaint is filed.

  - You can’t do anything unlawful, misleading, or fraudulent and can’t do anything for an illegal or unauthorized purpose. 

  - You can’t do anything to interfere with or impair the intended operation of the Service. 

  - You can’t use information in any way to harm another user. Study Cloud creates a safe environment with the purpose to enhance the educational experience of students. Anything in violation of this environment will be handled accordingly. 

  - You can’t force anyone to help you. Study Cloud provides students with the opportunity to find help or receive some type of monetary payment for assistance, but under no circumstance is any user required to help another. The helper is free to act on his will and can refuse his service for any reason at any time. 

  - Permissions you give to us. As a part of our agreement, you give us certain permissions in order to uphold our Service. 

  - You allow us to display your information publicly. Any information provided by you is free to be publicly displayed on Study Cloud. Information is free to be displayed for any students in the same school as you, and information can later be redistributed to areas outside of your school. 

  - You allow us to share information with schools. Any information that is stored in the Study Cloud backend can and will be shared with school upon request. 


Updating These Terms

We may change our Service and our policies at any given time. Any change in the terms and conditions will be alerted to you in the form of a notification or banner in the app. By agreeing to the terms and conditions at the time when you sign you up, you also agree to any future changes to the terms and conditions. 

''';








