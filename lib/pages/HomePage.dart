import 'package:flutter/material.dart';
import '../components/customtextfield.dart';
import 'package:http/http.dart';
import '../constants.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController seacrhtext = TextEditingController();
  bool isactive1 = true;
  bool isactive2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:const Color(0xFFFFFFED),

      body: Container(
        decoration: kBoxDecoration,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(

          child: Padding(
            padding: EdgeInsets.fromLTRB(20,MediaQuery.of(context).size.height * 0.06,20,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [SizedBox(
                          height: 3,
                        ),
                          Text("Hello User",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                          ),
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
                        child: Image.asset('assets/images/bababa.png'),
                      )
                    ]
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text("Moods",
                  style:TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Outfit',
                  ),),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 100,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    children: <Widget>[
                      Container(
                        height: 75,
                        width: 100,
                        // color: Colors.amber[600],
                        // child: const Center(child: Text('Entry A')),
                        child: Image.asset('assets/images/Entry A.png'),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        child: Image.asset('assets/images/Entry B.png'),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        child: Image.asset('assets/images/Entry c.png'),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        child: Image.asset('assets/images/Entry A.png'),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        child: Image.asset('assets/images/Entry B.png'),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        child: Image.asset('assets/images/Entry c.png'),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 55,
                ),
                customTextField("Type here",Icons.search,false, seacrhtext,),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: 150,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:  MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.search,color: Colors.white,),
                          SizedBox(width: 8.0),
                          Text('Search',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Outfit',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 55,
                ),
                const Text("Recommend By",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    fontFamily: 'Outfit',
                    color: Colors.white,
                  ),),

                const SizedBox(
                  height: 22.5,
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              isactive1 = true;
                              isactive2 = false;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:  MaterialStateProperty.all<Color>(isactive1 ? Colors.deepOrangeAccent : Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.emoji_emotions_rounded,color: isactive1 ? Colors.white : Colors.black,),
                              const SizedBox(width: 10.0),
                              Text('Emotions',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isactive1 ? Colors.white : Colors.black,
                                ),),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              isactive1 = false;
                              isactive2 = true;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:  MaterialStateProperty.all<Color>(isactive2 ? Colors.deepOrangeAccent: Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.music_note_sharp,color: isactive2 ? Colors.white : Colors.black,),
                              const SizedBox(width: 10.0),
                              Text('Music',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isactive2 ? Colors.white : Colors.black,
                                ),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}