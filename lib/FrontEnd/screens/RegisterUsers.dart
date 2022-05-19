import 'package:flutter/material.dart';
import 'package:nitc_telehealth_application/FrontEnd/screens/Login_Page.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class RegisterUsersPage extends StatefulWidget {
  const RegisterUsersPage({Key? key}) : super(key: key);

  @override
  State<RegisterUsersPage> createState() => _RegisterUsersPageState();
}

class _RegisterUsersPageState extends State<RegisterUsersPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: HexColor('#283B71'),
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
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 30,
                ),
              ),
            ),
            ListTile(
              title: const Text('Create Schedule'),
              onTap: () {
                Navigator.pushNamed(context, "/schedule");
              },
            ),
            ListTile(
              title: const Text('Print Medical Certificate'),
              onTap: () {
                Navigator.pushNamed(context, "/printcerti");
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: HexColor('#283B71'),
        title: Text(
          "Register User",
        ),
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
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20,
        ),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          scrollDirection: Axis.vertical,
          children: [
            Material(
              color: HexColor('#283b71'),
              //borderRadius: BorderRadius.circular(25.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                splashColor: Colors.black,
                child: Container(
                  child: const Text(
                    'Add User',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/registeruser");
                },
              ),
            ),
            Material(
              color: HexColor('#283b71'),
              //borderRadius: BorderRadius.circular(25.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                splashColor: Colors.black,
                child: Container(
                  child: const Text(
                    'Remove User',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/deleteuser");
                },
              ),
            ),
            Material(
              color: HexColor('#283b71'),
              //borderRadius: BorderRadius.circular(25.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                splashColor: Colors.black,
                child: Container(
                  child: const Text(
                    'Add Admin',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/registeradmin");
                },
              ),
            ),
            Material(
              color: HexColor('#283b71'),
              //borderRadius: BorderRadius.circular(25.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                splashColor: Colors.black,
                child: Container(
                  child: const Text(
                    'Remove Admin',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/deleteadmin");
                },
              ),
            ),
            Material(
              color: HexColor('#283b71'),
              //borderRadius: BorderRadius.circular(25.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                splashColor: Colors.black,
                child: Container(
                  child: const Text(
                    'Add Doctor',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/registerdoctor");
                },
              ),
            ),
            Material(
              color: HexColor('#283b71'),
              //borderRadius: BorderRadius.circular(25.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                splashColor: Colors.black,
                child: Container(
                  child: const Text(
                    'Remove Doctor',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/deletedoctor");
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
