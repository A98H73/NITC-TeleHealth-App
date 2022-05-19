import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../services/RemoveData.dart';
import 'package:dio/dio.dart';

class DeleteUser extends StatefulWidget {
  const DeleteUser({Key? key}) : super(key: key);

  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  bool isAPICallProcess = false;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? email;
  String? name;
  String? type;
  String? branch;
  String? rollno;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#283B71'),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _deleteuserUI(context),
          ),
          inAsyncCall: isAPICallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _getAllTexts() {
    if (name != null && type != null && branch != null && rollno != null) {
      return Column(
        children: [
          Text('Name        = $name'),
          Text('User Type  = $type'),
          Text('Branch     = $branch'),
          Text('Roll No      = $rollno'),
        ],
      );
    }
    return Column(
      children: [],
    );
  }

  Widget _deleteuserUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                  ]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/NITC_logo.jpg",
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 30,
              bottom: 20,
            ),
            child: Center(
              child: Text(
                "Remove User",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: TextFormField(
              controller: TextEditingController(text: email),
              onChanged: (value) {
                email = value;
              },
              validator: (value) {
                if (value == null) {
                  return "Email can't be empty";
                } else {
                  return null;
                }
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter Email",
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              child: Text("Search User"),
              onPressed: () {
                if (globalFormKey.currentState!.validate()) {
                  RemoveUser().getData(email).then((val) {
                    if (val.data['success']) {
                      name = val.data['name'];
                      type = val.data['type'];
                      branch = val.data['branch'];
                      rollno = val.data['rollno'];
                    }
                    print(val.data);
                    setState(() {});
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: HexColor("#283B71"),
                  side: BorderSide(
                    width: 1.0,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(80.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 20,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              color: Colors.white,
              child: Align(
                alignment: Alignment.center,
                child: _getAllTexts(),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              child: Text("Remove User"),
              onPressed: () {
                if (globalFormKey.currentState!.validate()) {
                  RemoveUser().DeleteUser(email).then((val) {
                    if (val.data['deletecount'] >= 1) {
                      Fluttertoast.showToast(
                        msg: "$name Data removed",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      setState(() {});
                    }
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: HexColor("#283B71"),
                  side: BorderSide(
                    width: 1.0,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(80.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
