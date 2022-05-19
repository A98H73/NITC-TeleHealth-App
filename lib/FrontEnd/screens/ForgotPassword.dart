import 'package:email_auth/email_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/BookAppointment.dart';
import 'package:nitc_telehealth_application/FrontEnd/services/authservice.dart';
import 'package:nitc_telehealth_application/FrontEnd/services/updateAllUsers.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class ForgotPasswd extends StatefulWidget {
  const ForgotPasswd({Key? key}) : super(key: key);

  @override
  State<ForgotPasswd> createState() => _ForgotPasswdState();
}

class _ForgotPasswdState extends State<ForgotPasswd> {
  bool isAPICallProcess = false;
  bool hidePassword = true;
  bool chidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? cnfpasswd;
  String? name;

  String? otp;
  String? type;
  bool _verified = false;

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _otpController = new TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("User"), value: "user"),
      DropdownMenuItem(child: Text("Admin"), value: "admin"),
      DropdownMenuItem(child: Text("Doctor"), value: "doctor"),
    ];
    return menuItems;
  }

  EmailAuth? emailAuth;

  // void initState() {
  //   emailAuth = new EmailAuth(
  //     sessionName: "Sample session",
  //   );

  //   /// Configuring the remote server
  //   emailAuth.config(remoteServerConfiguration);
  // }
  @override
  void initState() {
    super.initState();
    // Initialize the package
    emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );
  }

  void sendOtp() async {
    bool result = await emailAuth!
        .sendOtp(recipientMail: _emailController.value.text, otpLength: 5);
  }

  void sendOTP() async {
    var res = await emailAuth!
        .sendOtp(recipientMail: _emailController.text, otpLength: 5);

    if (res) {
      print("OTP Sent Successfully");
      Fluttertoast.showToast(
        msg: "OTP Sent Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      print("OTP Not Sent, Something went wrong");
      Fluttertoast.showToast(
        msg: "OTP Not Sent, Something went wrong",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void verifyOTP() {
    var res = emailAuth!.validateOtp(
        recipientMail: _emailController.text, userOtp: _otpController.text);
    if (res) {
      _verified = true;
      Fluttertoast.showToast(
        msg: "OTP VERIFIED",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      _verified = false;
      Fluttertoast.showToast(
        msg: "INVALID OTP",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Forgot Password",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: HexColor('#283B71'),
        ),
        backgroundColor: HexColor('#283B71'),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _forgotPasswdUI(context),
          ),
          inAsyncCall: isAPICallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _forgotPasswdUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
                    "assets/images/forgotpassword.jpg",
                    width: 220,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 80,
              left: 20,
              right: 20,
            ),
            child: TextFormField(
              controller: _emailController,
              onChanged: (value) {
                email = value;
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
                labelText: "Email",
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
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                prefixIconColor: Colors.white,
                suffixIcon: TextButton(
                  onPressed: () => sendOTP(),
                  child: Text("Sent OTP"),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 30,
            ),
            child: DropdownButtonFormField(
              items: dropdownItems,
              value: type,
              onChanged: (String? newValue) {
                setState(() {
                  type = newValue!;
                });
              },
              dropdownColor: HexColor('#283B71'),
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                labelText: "Select Type",
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                //fillColor: Colors.blueAccent,
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
              controller: _otpController,
              onChanged: (value) {
                otp = value;
              },
              validator: (value) {
                if (value == null) {
                  return 'Field cannot be empty';
                }
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter OTP",
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
                suffixIcon: TextButton(
                  onPressed: () => verifyOTP(),
                  child: Text("Verify OTP"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          if (_verified)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    controller: TextEditingController(text: password),
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Password can't be empty";
                      } else {
                        return null;
                      }
                    },
                    obscureText: hidePassword,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
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
                    controller: TextEditingController(text: cnfpasswd),
                    onChanged: (value) {
                      cnfpasswd = value;
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Password can't be empty";
                      } else {
                        return null;
                      }
                    },
                    obscureText: chidePassword,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter Confirm Password",
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          chidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        onPressed: () {
                          setState(() {
                            chidePassword = !chidePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                      child: Text("RESET PASSWORD"),
                      onPressed: () {
                        if (globalFormKey.currentState!.validate()) {
                          if (password == cnfpasswd && type == "user") {
                            UpdateUsers()
                                .updatePatient(
                                    type, _emailController.text, password)
                                .then((val) {
                              if (val.data['success']) {
                                Fluttertoast.showToast(
                                  msg: 'Password Updated Successfully',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'Something Went Wrong',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            });
                          } else if (password == cnfpasswd && type == "admin") {
                            UpdateUsers()
                                .updateAdmin(type, email, password)
                                .then((val) {
                              print(val.data);
                              if (val.data['success']) {
                                Fluttertoast.showToast(
                                  msg: 'Password Updated Successfully',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'Something Went Wrong',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            });
                          } else if (password == cnfpasswd &&
                              type == "doctor") {
                            UpdateUsers()
                                .updateDoc(type, email, password)
                                .then((val) {
                              print(val);
                              if (val.data['success']) {
                                Fluttertoast.showToast(
                                  msg: 'Password Updated Successfully',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'Something Went Wrong',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            });
                          }

                          //Navigator.pushNamed(context, MyRoutings.homeRoute);

                          // if (type == "user") {
                          //   AuthService().loginUser(email, password).then((val) {
                          //     if (val.data['success']) {
                          //       token = val.data['token'];
                          // Fluttertoast.showToast(
                          //   msg: 'Authenticated',
                          //   toastLength: Toast.LENGTH_SHORT,
                          //   gravity: ToastGravity.BOTTOM,
                          //   timeInSecForIosWeb: 1,
                          //   backgroundColor: Colors.green,
                          //   textColor: Colors.white,
                          //   fontSize: 16.0,
                          // );

                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) =>
                          //                   BookAppointments(token: token!)));
                          //     }
                          //   });
                          // } else if (type == "admin") {
                          //   AuthService().loginAdmin(email, password).then((val) {
                          //     if (val.data['success']) {
                          //       token = val.data['token'];
                          //       Fluttertoast.showToast(
                          //         msg: 'Authenticated',
                          //         toastLength: Toast.LENGTH_SHORT,
                          //         gravity: ToastGravity.BOTTOM,
                          //         timeInSecForIosWeb: 1,
                          //         backgroundColor: Colors.green,
                          //         textColor: Colors.white,
                          //         fontSize: 16.0,
                          //       );
                          //       Navigator.pushNamed(context, "/register");
                          //     }
                          //   });
                          // } else if (type == "doctor") {
                          //   AuthService().loginDoctor(email, password).then((val) {
                          //     if (val.data['success']) {
                          //       token = val.data['token'];
                          //       Fluttertoast.showToast(
                          //         msg: 'Authenticated',
                          //         toastLength: Toast.LENGTH_SHORT,
                          //         gravity: ToastGravity.BOTTOM,
                          //         timeInSecForIosWeb: 1,
                          //         backgroundColor: Colors.green,
                          //         textColor: Colors.white,
                          //         fontSize: 16.0,
                          //       );
                          //     }
                          //   });
                          // }
                        } else {
                          "problem signin- check";
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: HexColor("#283B71"),
                          side: BorderSide(
                            width: 1.0,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ))),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
