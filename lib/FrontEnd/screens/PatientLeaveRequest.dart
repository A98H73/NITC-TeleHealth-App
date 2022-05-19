import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nitc_telehealth_application/FrontEnd/services/addMedLeave.dart';
import 'package:nitc_telehealth_application/FrontEnd/services/adduser.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class RequestMedLeave extends StatefulWidget {
  final String token;
  const RequestMedLeave({Key? key, required this.token}) : super(key: key);

  @override
  State<RequestMedLeave> createState() => _RequestMedLeaveState();
}

class _RequestMedLeaveState extends State<RequestMedLeave> {
  bool isAPICallProcess = false;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  Map<String, dynamic>? decodedToken;

  String? doc_name;
  String? doc_email;
  String? doc_spec_in;
  String? user_name;
  String? user_email;
  String? user_rollno;
  String? user_branch;
  String? issue_face;
  bool doc_isaccepted = false;
  bool admin_isaccepted = false;

  @override
  void initState() {
    // TODO: implement initState
    decodedToken = JwtDecoder.decode(widget.token);
    doc_name = decodedToken!['name'];
    doc_email = decodedToken!['email'];
    doc_spec_in = decodedToken!['spec_in'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Medical Leave Page",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: HexColor('#283B71'),
        ),
        backgroundColor: HexColor('#283B71'),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _MedicalLeaveUI(context),
          ),
          inAsyncCall: isAPICallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _MedicalLeaveUI(BuildContext context) {
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
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/medical_leave.png",
                    width: 230,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: TextFormField(
              controller: TextEditingController(text: user_name),
              onChanged: (value) {
                user_name = value;
              },
              validator: (value) {
                if (value == null) {
                  return 'Field cannot be empty';
                }
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter Patient Name",
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: TextFormField(
              controller: TextEditingController(text: user_email),
              onChanged: (value) {
                user_email = value;
              },
              validator: (value) {
                if (value == null) {
                  return 'Field cannot be empty';
                } else if (RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return null;
                } else {
                  return 'Enter Valid Email';
                }
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter Patient Email",
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: TextFormField(
              controller: TextEditingController(text: user_rollno),
              onChanged: (value) {
                user_rollno = value;
              },
              validator: (value) {
                if (value == null) {
                  return 'Field cannot be empty';
                }
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter Patient RollNo",
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: TextFormField(
              controller: TextEditingController(text: user_branch),
              onChanged: (value) {
                user_branch = value;
              },
              validator: (value) {
                if (value == null) {
                  return 'Field cannot be empty';
                }
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter Patient Branch",
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: TextFormField(
              controller: TextEditingController(text: issue_face),
              onChanged: (value) {
                issue_face = value;
              },
              validator: (value) {
                if (value == null) {
                  return 'Field cannot be empty';
                }
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Issue Facing",
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 30,
              right: 30,
            ),
            child: Row(
              children: [
                Text(
                  "Accept Request",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  width: 110,
                ),
                Transform.scale(
                  scale: 2.0,
                  child: Checkbox(
                      value: doc_isaccepted,
                      shape: CircleBorder(),
                      tristate: false,
                      splashRadius: 30,
                      //activeColor: Colors.white,
                      onChanged: (bool? value) {
                        setState(() {
                          doc_isaccepted = value!;
                        });
                      }),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
                child: Text("SUBMIT"),
                onPressed: () {
                  if (globalFormKey.currentState!.validate()) {
                    print(doc_email);
                    print(doc_name);
                    print(doc_spec_in);
                    print(user_email);
                    print(user_name);
                    print(user_branch);
                    print(user_rollno);
                    print(issue_face);
                    print(doc_isaccepted);
                    print(admin_isaccepted);
                    MedicalLeaveReq()
                        .AddMedLeave(
                            doc_email,
                            doc_name,
                            doc_spec_in,
                            user_name,
                            user_email,
                            user_rollno,
                            user_branch,
                            issue_face,
                            doc_isaccepted,
                            admin_isaccepted)
                        .then((val) {
                      if (val.data['success']) {
                        //token = val.data['token'];
                        Fluttertoast.showToast(
                          msg: 'Medical Leave request Accepted',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 4,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RequestMedLeave(
                                token: widget.token,
                              ),
                            ));
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Something Went Wrong',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 4,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    });
                  } else {
                    print("Something Went Wrong");
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: HexColor("#283B71"),
                    side: BorderSide(
                      width: 1.0,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ))),
          ),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
