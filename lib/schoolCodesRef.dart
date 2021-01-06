import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';

final schoolSearchBar = TextEditingController();
double codeCopied = 0;
String copiedSchool = "Code copied for ";

List<String> searchingSchoolsArray = [];

class codesRef extends StatefulWidget {
  @override
  _codesRefState createState() => _codesRefState();
}

class _codesRefState extends State<codesRef> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 50, 16, 0),
            child: Text("Search for your school. Tap on the school to copy the school code!",
              style: TextStyle(fontSize: 20, fontFamily: 'Alegreya', color: studycloudred), textAlign: TextAlign.center,),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    controller: schoolSearchBar,
                    decoration: InputDecoration(
                      enabledBorder: new OutlineInputBorder(
                          borderSide: BorderSide(color: studycloudblue)
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: studycloudblue)
                      ),
                      contentPadding: EdgeInsets.all(16),
                      isDense: true,
                      hintText: "School Name",
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                child: RaisedButton(
                  color: studycloudblue,
                  child: Text("Search", style: TextStyle(fontSize: 20, fontFamily: 'Alegreya', color: Colors.white), textAlign: TextAlign.center,),
                  onPressed: () {
                    final search = schoolSearchBar.text;
                    setState(() {
                      searchingSchoolsArray = schoolsArray.where((school) => school.toLowerCase().trim().contains(search.toLowerCase().trim())).toSet().toList();
                      if (searchingSchoolsArray.isEmpty) {
                        searchingSchoolsArray = ["No results!"];
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          Opacity(
            opacity: codeCopied,
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(copiedSchool, style: TextStyle(fontSize: 20, fontFamily: 'Alegreya', color: studycloudred), textAlign: TextAlign.center,),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            height: 750,
            child: ListView(
              children: [
                for (var school in searchingSchoolsArray) Container(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: FlatButton(
                    textColor: Colors.black,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(school, style: TextStyle(fontSize: 20, fontFamily: 'Alegreya'), textAlign: TextAlign.start,),
                    ),
                    onPressed: () {
                      setState(() {
                        final schoolIndex = schoolsArray.indexOf(school);
                        if (schoolIndex != -1) {
                          final code = schoolCodesArray[schoolIndex];
                          if (code != null) {
                            copiedSchool += school + '!';
                            codeCopied = 1;
                            Clipboard.setData(new ClipboardData(text: code));
                          } else {
                            copiedSchool = "Error retrieving school code!";
                            codeCopied = 1;
                          }
                        } else {
                          copiedSchool = "Error retrieving school code!";
                          codeCopied = 1;
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}