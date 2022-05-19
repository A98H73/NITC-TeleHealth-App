import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nitc_telehealth_application/FrontEnd/screens/BookAppointment.dart';
import 'package:nitc_telehealth_application/FrontEnd/services/bookslot.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../services/RemoveData.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class CancelAppointments extends StatefulWidget {
  final String token;
  const CancelAppointments({Key? key, required this.token}) : super(key: key);

  @override
  State<CancelAppointments> createState() => _CancelAppointmentsState();
}

class _CancelAppointmentsState extends State<CancelAppointments> {
  bool isAPICallProcess = false;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  Map<String, dynamic>? decodedToken;
  String? user_email;
  String? user_name;
  String? date;
  String? slot;
  String? doc_name;
  String? doc_email;
  String? doc_spec_in;
  String? descreption;
  bool app_booked = true;
  bool _selectSlotValue = false;
  String? start_time;
  String? end_time;
  String? _id;

  Future<List<UserValue>> _getSlots() async {
    Dio dio = new Dio();

    var value = await dio.post(
      'https://nitc-tele-health-app.herokuapp.com/bookedslots',
      data: {
        "user_email": user_email,
        "app_booked": app_booked,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    // final value = await http.post(
    //   Uri.parse('https://nitc-tele-health-app.herokuapp.com/searchslot'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, String>{'date': date, 'slot': slot}),
    // );

    if (value.statusCode == 200) {
      //List<LoadSlot> slot_book = [];
      List<UserValue> sloting = [];
      print(user_email);
      print(app_booked);

      List<dynamic> str = value.data['user'];
      // print(str[1]['doc_name']);

      for (var u in str) {
        UserValue usr = new UserValue(
            u['_id'],
            u['date'],
            u['slot'],
            u['start_time'],
            u['end_time'],
            u['doc_name'],
            u['doc_email'],
            u['doc_spec_in'],
            u['descreption'],
            u['app_booked'],
            u['user_name'],
            u['user_email']);

        sloting.add(usr);
      }

      print(sloting.length);

      return sloting;
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    decodedToken = JwtDecoder.decode(widget.token);
    user_email = decodedToken!['email'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Cancel Appointments",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: HexColor("#283B71"),
        ),
        backgroundColor: HexColor("#283B71"),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _cancelAppUI(context),
          ),
          inAsyncCall: isAPICallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _cancelAppUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: FutureBuilder(
                future: _getSlots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text("Loading...."),
                      ),
                    );
                  } else {
                    if (snapshot.data.length > 0) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              title: Center(
                                child: Text(
                                  "${snapshot.data[index].doc_name}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              subtitle: Column(
                                children: <Widget>[
                                  Text(
                                    "Date: ${snapshot.data[index].date}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Slot: ${snapshot.data[index].slot}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Timing: ${snapshot.data[index].start_time} - ${snapshot.data[index].end_time}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Specilist In: ${snapshot.data[index].doc_spec_in}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Booking type: ${snapshot.data[index].app_booked}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              //tileColor: bgcolor,
                              onTap: () {
                                if (snapshot.data[index].app_booked == true) {
                                  date = snapshot.data[index].date;
                                  slot = snapshot.data[index].slot;
                                  doc_name = snapshot.data[index].doc_name;
                                  doc_email = snapshot.data[index].doc_email;
                                  doc_spec_in =
                                      snapshot.data[index].doc_spec_in;
                                  start_time = snapshot.data[index].start_time;
                                  end_time = snapshot.data[index].end_time;
                                  _id = snapshot.data[index]._id;

                                  print(start_time);
                                  print(end_time);
                                  print(snapshot.data[index]._id);
                                  print("the token in app: ${widget.token}");
                                  print(
                                      "User Name is: ${decodedToken!['name']}");
                                  setState(() {
                                    _selectSlotValue = true;
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                    msg: 'Error: Slot is already Booked',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                                "Appointments are not being created for this day yet...."),
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                    ]),
                // borderRadius: BorderRadius.only(
                //   bottomLeft: Radius.circular(20),
                //   bottomRight: Radius.circular(20),
                //   topLeft: Radius.circular(20),
                //   topRight: Radius.circular(20),
                // ),
              ),
            ),
          ),
          if (_selectSlotValue)
            Center(
                child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Text(
                "Selected slot: $start_time - $end_time",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
          SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
                child: Text("CANCEL APPOINTMENT"),
                onPressed: () {
                  print("testing");
                  if (globalFormKey.currentState!.validate()) {
                    app_booked = false;
                    user_name = "";
                    user_email = "";
                    descreption = "";
                    print(_id);
                    print(date);
                    print(slot);
                    print(start_time);
                    print(end_time);
                    print(doc_name);
                    print(doc_email);
                    print(doc_spec_in);
                    print(descreption);
                    print(user_name);
                    print(app_booked);
                    print(user_email);
                    ListBookedSlot()
                        .cancelApp(
                            _id,
                            date,
                            slot,
                            start_time,
                            end_time,
                            doc_name,
                            doc_email,
                            doc_spec_in,
                            descreption,
                            app_booked,
                            user_name,
                            user_email)
                        .then((val) {
                      print(val.data);
                      if (val.data['success']) {
                        Fluttertoast.showToast(
                          msg: 'Appointment Cancelled Successfully',
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
                                builder: (context) =>
                                    BookAppointments(token: widget.token)));
                      } else if (!val.data['success']) {
                        Fluttertoast.showToast(
                          msg: val.data['msg'],
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
                    print("problem signin- check");
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
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ))),
          ),
        ],
      ),
    );
  }
}

class LoadSlot {
  final List<UserValue> allvalue;

  LoadSlot(this.allvalue);
}

class UserValue {
  final String? _id;
  final String date;
  final String slot;
  final String start_time;
  final String end_time;
  final String doc_name;
  final String doc_email;
  final String doc_spec_in;
  final bool app_booked;
  final String descreption;
  final String user_name;
  final String user_email;

  UserValue(
    this._id,
    this.date,
    this.slot,
    this.start_time,
    this.end_time,
    this.doc_name,
    this.doc_email,
    this.doc_spec_in,
    this.descreption,
    this.app_booked,
    this.user_name,
    this.user_email,
  );
}
