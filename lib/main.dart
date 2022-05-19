import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/BookAppNow.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/BookAppointment.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/CancelAppointment.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/ForgotPassword.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/Login_Page.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/PatientLeaveRequest.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/PrintMedicalCerti.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/RegisterUsers.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/Register_admin_page.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/Register_doctor_page.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/Register_user_page.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/Schedule.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/delete_admin.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/delete_doctor.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/delete_user.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/docCancelApp.dart';
import 'FrontEnd/screens/RegisterUsers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo App',
      theme: ThemeData(
        primaryColor: Colors.lightBlue[800],
      ),
      routes: {
        '/': (context) => const LoginPage(),
        '/forgotpasswd': (context) => ForgotPasswd(),
        '/registeruser': (context) => const RegisterUser(),
        '/registerdoctor': (context) => const RegisterDoctor(),
        '/registeradmin': (context) => const RegisterAdmin(),
        '/register': (context) => const RegisterUsersPage(),
        '/deleteuser': (context) => const DeleteUser(),
        '/deleteadmin': (context) => const DeleteAdmin(),
        '/deletedoctor': (context) => const DeleteDoctor(),
        '/schedule': (context) => const CreateSchedule(),
        '/printcerti': (context) => const PrintMedicalCertificate(),
        '/appointment': (context) => BookAppointments(
              token: "",
            ),
        // '/': (context) => BookAppointments(),
        '/bookappnow': (context) => BookAppNow(
              problemtype: "",
              token: "",
            ),
        '/usercancelapp': (context) => CancelAppointments(
              token: "",
            ),
        '/doccancelapp': (context) => DocCancelAppointment(
              token: "",
            ),
        '/requestmedleave': (context) => RequestMedLeave(
              token: "",
            ),
      },
    );
  }
}
