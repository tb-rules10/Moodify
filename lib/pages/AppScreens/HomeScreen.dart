import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moodify/pages/AppScreens/Dashboard.dart';
import 'package:moodify/pages/AppScreens/PlaylistScreen.dart';
import 'package:moodify/pages/AppScreens/RecommendationScreen.dart';
import 'package:moodify/utils/API-Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/playlistCard.dart';
import '../../constants/textStyles.dart';
import '../../components/inputFields.dart';
import '../BottomNavbar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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
  String username = "User";
  String photoUrl = "https://user-images.githubusercontent.com/58645688/235341154-ae99214b-c447-47e2-9c92-3f82abd7cdf9.png";
  bool loader = false;

  Future<void> getDetails() async{
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      var name = user.displayName ?? username;
      int index = name.indexOf(" ");
      if(index!=-1) name =  name.substring(0, name.indexOf(" "));
      username = name;
      photoUrl = user.photoURL ?? photoUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: loader,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 80,
                    // color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FutureBuilder(
                              future: getDetails(),
                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                return Text(
                                  "Hello $username",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.outfit(
                                    textStyle: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.secondary,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text("Let's Play Some Music !",
                                style: GoogleFonts.outfit(
                                    textStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                ))),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, Dashboard.id);
                              },
                              child: FutureBuilder(
                                future: getDetails(),
                                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                  return CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage(photoUrl),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SearchInputField(
                      myController: myController,
                      hintText: "What do you want to listen to?",
                      onSubmitted: (query){
                        query = query?.trimLeft();
                        if(query != ""){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavbar(
                                searchQuery: query,
                              ),
                            ),
                          );
                        }
                      },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, RecommendationScreen.id);
                    },
                    child: Container(
                      height: 120,
                      width: width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.white, // set the border color with opacity
                          width: 1.0, // set the border width
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Visibility(
                              // maintainSize: true,
                              // maintainAnimation: true,
                              // maintainState: true,
                              visible: false,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Icon(
                                    Icons.more_horiz,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Get recommendations based on your mood",
                                    style: GoogleFonts.outfit(
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Tell us how are you feeling?",
                                    style: GoogleFonts.outfit(
                                      textStyle: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    // maintainSize: true,
                                    // maintainAnimation: true,
                                    // maintainState: true,
                                    // visible: false,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Icon(
                                          Icons.navigate_next,
                                          size: 30,
                                        )
                                      ],
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

                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Daily Mix",
                    style: kPlaylistTileStyle,
                  ),
              Container(
                height: 200,
                width: width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: dailyMix.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          loader = true;
                        });
                        List<Songs> list = [];
                        await playlistsData("dailyMix", dailyMix[index].id).then((results) {
                          for(var result in results){
                            var json = jsonDecode(result);
                            setState(() {
                              list.add(Songs.fromJson(json));
                            });
                          }
                        });
                        setState(() {
                          loader = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlaylistScreen(
                              title: 'Daily Mix ${dailyMix[index].id}',
                              songs: list,
                            ),
                          ),
                        );
                      },
                      child: PlaylistCard(
                        imageUrl: dailyMix[index].iconUrl,
                        text: dailyMix[index].title,
                      ),
                    );
                  },
                ),
              ),

                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "All Time Best",
                    style: kPlaylistTileStyle,
                  ),
                  Container(
                    height: 200,
                    width: width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: albums.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            setState(() {
                              loader = true;
                            });
                            List<Songs> list = [];
                            await playlistsData("albums", albums[index].id).then((results) {
                              for(var result in results){
                                var json = jsonDecode(result);
                                setState(() {
                                  list.add(Songs.fromJson(json));
                                });
                              }
                            });
                            setState(() {
                              loader = false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlaylistScreen(
                                  title: '${albums[index].title}',
                                  songs: list,
                                ),
                              ),
                            );
                          },
                          child: PlaylistCard(
                            imageUrl: albums[index].iconUrl,
                            text: albums[index].title,
                          ),
                        );
                      },
                    ),
                  ),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


Future<List<String>> playlistsData(String urlPostfix, String type) async {
  try {
    final url = Uri.parse('https://moodify-backend.onrender.com/api/$urlPostfix');
    Map<String, String> data = {'text': type};
    String body = jsonEncode(data);
    // Use `data` in request body if using Node.js server as backend
    // Use `body` in request body if using FastAPI server as backend
    final response =
    await http.post(url, body: body).timeout(const Duration(seconds: 15));
    Map<String, dynamic> temp = await json.decode(response.body);
    // print(temp['data']);
    List<String> songs = List<String>.from(temp['data'] as List);
    // print(songs);
    // return [];
    return songs;
  } catch (e) {
    print("ERROR - $e");
    return [];
  }
}

