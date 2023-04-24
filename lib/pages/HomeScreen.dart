import 'package:flutter/material.dart';
import '../constants/textStyles.dart';

class HomeScreen extends StatefulWidget {
  static String id = "HomeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController myController = TextEditingController();
  bool isactive1 = true;
  bool isactive2 = false;
  String username = "Emily";

  @override
  Widget build(BuildContext context) {
    height: MediaQuery.of(context).size.height;
    width: MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor:const Color(0xFFFFFFED),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.06, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Hello $username",
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Let's Play Some Music !",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ],
                  ),
                  Container(
                    // height: 100,
                    child: Image.asset('assets/images/user-icon.png'),
                  ),
                ],),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
