import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:moodify/pages/BottomNavbar.dart';
import '../../constants/functions.dart';
import '../../utils/API-Model.dart';
import '../../components/videoPlayer.dart';
import '../../components/inputFields.dart';
import '../../api_key.dart';
import '../../constants/textStyles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  static String id = "SearchScreen";

  String? searchQuery;
  SearchScreen({
    this.searchQuery,
  });
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  TextEditingController myController = TextEditingController();
  bool showResults = false;
  bool fromHome = false;
  List<Songs> recentSearches = [];
  List<Video> videos = [];

  @override
  void initState() {
    super.initState();
    getRecentSearches();
    if(widget.searchQuery != null){
      searchYoutube(widget.searchQuery!);
      setState(() {
        myController.text = widget.searchQuery!;
        showResults = true;
        fromHome = true;
      });
    }
  }
  @override
  void dispose() async{
    saveRecentSearches();
    super.dispose();
  }

  Future<void> saveRecentSearches() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> data = [];
    for(var search in recentSearches){
      data.add(jsonEncode(search));
    }
    prefs.setStringList('recentSearches', data);
  }

  Future<void> getRecentSearches() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? searches = prefs.getStringList('recentSearches');
    if(searches != null){
      for(String search in searches){
        // print(search);
        var json = jsonDecode(search);
        setState(() {
          recentSearches.add(Songs.fromJson(json));
        });
      }
    }
  }

  searchYoutube(String query) async {
    var url = "https://www.googleapis.com/youtube/v3/search"
        "?part=snippet"
        "&maxResults=7"
        "&q=$query"
        "&type=video"
        "&key=$apiKey";

    var response = await http.get(Uri.parse(url));
    // print(response.body.runtimeType);
    // print(response.runtimeType);
    var decodedJson = jsonDecode(response.body);
    // print(decodedJson.runtimeType);
    setState(() {
      videos = decodedJson['items'].map<Video>((item) {
        return Video.fromJson(item);
      }).toList();
    });
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: height*0.18,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: height*0.025,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (showResults)
                    MaterialButton(
                      shape: CircleBorder(),
                      color: Theme.of(context).colorScheme.primary,
                      padding: EdgeInsets.all(15.0),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                      onPressed: () {
                        (widget.searchQuery != null)? Navigator.pop(context) :
                        setState(() {
                          showResults = false;
                          myController.clear();
                        });
                      },
                    ),
                  Container(
                    width: (showResults) ? width * 0.785 : width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 15),
                      child: SearchInputField(
                        myController: myController,
                        hintText: "What do you want to listen to?",
                        borderRadius: 5,
                        onSubmitted: (query) {
                          if (query != null) {
                            setState(() {
                              showResults = true;
                            });
                            searchYoutube(query);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 18.0),
                child: Text(
                  (showResults) ? "Search Results" : "Recently Played",
                  style: const TextStyle(
                    fontSize: 28.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        // decoration: kBoxDecoration,
        child: (showResults)
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(
                      videos[index].thumbnailUrl,
                      height: 120,
                    ),
                    title: Text(
                      trimTitle(videos[index].title),
                      style: kMusicTitleStyle,
                    ),
                    subtitle: Text(
                      videos[index].channelTitle,
                      style: kMusicInfoStyle,
                    ),
                    trailing: Icon(Icons.play_arrow, color: Colors.white,),
                    onTap: () => {
                      recentSearches.insert(0, Songs(
                          id: videos[index].id,
                          channelTitle: videos[index].channelTitle,
                          title: trimTitle(videos[index].title),
                          thumbnailUrl: videos[index].thumbnailUrl,
                      ),
                      ),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(
                            videoId: videos[index].id,
                            thumbnailUrl: videos[index].thumbnailUrl,
                            title: trimTitle(videos[index].title),
                            channelTitle: videos[index].channelTitle,
                          ),
                        ),
                      )
                    },
                  );
                },
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: recentSearches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(recentSearches[index].thumbnailUrl),
                    subtitle: Text(
                      recentSearches[index].channelTitle,
                      style: kMusicInfoStyle,
                    ),
                    title: Text(
                        recentSearches[index].title,
                        style: kMusicTitleStyle,
                    ),
                    trailing: GestureDetector(
                      onTap: (){
                        setState(() {
                          recentSearches.remove(recentSearches[index]);
                        });
                      },
                      child: Icon(Icons.close_sharp, color: Colors.grey,),
                    ),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(
                            videoId: recentSearches[index].id,
                            thumbnailUrl: recentSearches[index].thumbnailUrl,
                            title: recentSearches[index].title,
                            channelTitle: recentSearches[index].channelTitle,
                          ),
                        ),
                      )
                    },
                  );
                },
              ),
      ),
    );
  }
}


