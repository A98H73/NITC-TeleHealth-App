import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/BookAppointment.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/Login_Page.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/PatientLeaveRequest.dart';
import 'package:nitc_telehealth_application/FrontEnd/services/bookslot.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../services/RemoveData.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DocCancelAppointment extends StatefulWidget {
  final String token;
  const DocCancelAppointment({Key? key, required this.token}) : super(key: key);

  @override
  State<DocCancelAppointment> createState() => _DocCancelAppointmentState();
}

class _DocCancelAppointmentState extends State<DocCancelAppointment> {
  bool isAPICallProcess = false;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  Future<List<UserValue>>? _futureData;

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

  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = new TextEditingController();

  Future<String> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
        date = _dateController.text;
        // print("value of: " + _dateController.text);
        date = _dateController.text;
      });
    return _dateController.text;
  }

  Future<List<UserValue>> _getSlots() async {
    Dio dio = new Dio();

    var value = await dio.post(
      'https://nitc-tele-health-app.herokuapp.com/searchdocslots',
      data: {
        "doc_email": doc_email,
        "doc_spec_in": doc_spec_in,
        "date": date,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    if (value.statusCode == 200) {
      //List<LoadSlot> slot_book = [];
      List<UserValue> sloting = [];
      print(user_email);
      print(doc_spec_in);

      List<dynamic> str = value.data['user'];

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
    doc_email = decodedToken!['email'];
    doc_spec_in = decodedToken!['spec_in'];

    super.initState();
  }

  void _printdate() {
    print("The Date is: ${date}");
    print("the token is: $widget.token");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "List Appointments",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: HexColor("#283B71"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement<void, void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const LoginPage(),
                    ),
                  );
                },
                icon: Icon(Icons.logout)),
          ],
        ),
        backgroundColor: HexColor("#283B71"),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _docCancelAppUI(context),
          ),
          inAsyncCall: isAPICallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage("assets/images/NITC_logo.jpg"),
                    )),
                child: Text(
                  '',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                title: const Text('Patient Leave Request'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RequestMedLeave(
                          token: widget.token,
                        ),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _docCancelAppUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.red)),
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: _dateController,
                    onChanged: (value) {
                      _printdate();
                      date = _dateController.text;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Date",
                      hintStyle: TextStyle(color: Colors.white),
                      icon: Icon(
                        Icons.date_range,
                        size: 25.0,
                        color: Colors.white,
                      ),
                    ),
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
                child: Text("SHOW LIST"),
                onPressed: () {
                  if (globalFormKey.currentState!.validate()) {
                    //Navigator.pushNamed(context, MyRoutings.homeRoute);
                    setState(() {
                      print(doc_email);
                      print(doc_spec_in);
                      print(date);
                      _futureData = _getSlots();
                    });
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
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ))),
          ),
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
                future: _futureData,
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
                                date = snapshot.data[index].date;
                                slot = snapshot.data[index].slot;
                                doc_name = snapshot.data[index].doc_name;
                                doc_email = snapshot.data[index].doc_email;
                                doc_spec_in = snapshot.data[index].doc_spec_in;
                                start_time = snapshot.data[index].start_time;
                                end_time = snapshot.data[index].end_time;
                                _id = snapshot.data[index]._id;

                                print(start_time);
                                print(end_time);
                                print(snapshot.data[index]._id);
                                print("the token in app: ${widget.token}");
                                print("User Name is: ${decodedToken!['name']}");
                                setState(() {
                                  _selectSlotValue = true;
                                });
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
                  if (globalFormKey.currentState!.validate()) {
                    if (_id!.isNotEmpty) {
                      ListBookedSlot().cancelDoctorAppointment(_id).then((val) {
                        if (val.data['deletecount'] >= 1) {
                          Fluttertoast.showToast(
                            msg: "Appointment is Removed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          setState(() {
                            _futureData = _getSlots();
                          });
                        } else {
                          Fluttertoast.showToast(
                            msg: "Something Went Wrong",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      });
                    }
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
          SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
                child: Text("RESET"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DocCancelAppointment(token: widget.token)));
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
          SizedBox(
            height: 100,
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
