import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moodify/components/buttons.dart';
import '../../components/floatingActionButton.dart';
import '../../components/inputFields.dart';
import '../../components/videoPlayer.dart';
import '../../constants/textStyles.dart';
import '../../utils/API-Model.dart';

class RecommendationScreen extends StatefulWidget {
  static String id = "RecommendationScreen";

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  List<Songs> recommendations = [];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        toolbarHeight: height*0.3,
        elevation: 0,
        flexibleSpace: Padding(
          padding: EdgeInsets.fromLTRB(20, height * 0.04, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GoBackButton(
                padding: EdgeInsets.fromLTRB(0, 25, 0, 5),
              ),
              Text(
                "Music Recommendation System",
                textAlign: TextAlign.left,
                style: GoogleFonts.outfit(
                  textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SearchInputField(
                hintText: "How are you feeling?",
                onSubmitted: (query){
                  query = query?.trimLeft();
                  if(query != ""){
                    postData(query!).then((results) {
                      for(var result in results){
                        var json = jsonDecode(result);
                        setState(() {
                          recommendations.add(Songs.fromJson(json));
                        });
                      }
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),

      body: Container(
        // height: double.infinity,
        child: (recommendations == []) ? null
            : ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: recommendations.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.network(recommendations[index].thumbnailUrl),
              subtitle: Text(
                recommendations[index].channelTitle,
                style: kMusicInfoStyle,
              ),
              title: Text(
                recommendations[index].title,
                style: kMusicTitleStyle,
              ),
              trailing: GestureDetector(
                onTap: (){
                  setState(() {
                    recommendations.remove(recommendations[index]);
                  });
                },
                child: Icon(Icons.close_sharp, color: Colors.grey,),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(
                      videoId: recommendations[index].id,
                      thumbnailUrl: recommendations[index].thumbnailUrl,
                      title: recommendations[index].title,
                      channelTitle: recommendations[index].channelTitle,
                    ),
                  ),
                )
              },
            );
          },
        ),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingButton(
            backgroundColor: Colors.green,
            iconData: Icons.playlist_add,
            padding: EdgeInsets.only(left: 32.0),
            heroTag: "playlist",
            onPressed: (){},
          ),
          FloatingButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            iconData: Icons.play_arrow,
            padding: EdgeInsets.only(right: 0.0),
            heroTag: "play",
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}



Future<List<String>> postData(String inputText) async {
  try {
    final url = Uri.parse('http://10.0.2.2:5000/api/predict');
    Map<String, String> data = {'text': inputText};
    String body = jsonEncode(data);
    // Use `data` in request body if using Node.js server as backend
    // Use `body` in request body if using FastAPI server as backend
    final response =
    await http.post(url, body: body).timeout(const Duration(seconds: 5));
    Map<String, dynamic> temp = await json.decode(response.body);
    // print(temp['data'].runtimeType);
    List<String> songs = List<String>.from(temp['data'] as List);
    // print(songs);
    // return [];
    return songs;
  } catch (e) {
    print("ERROR - $e");
    return [];
  }
}