import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:demo_music/models/API-Model.dart';
import 'package:demo_music/components/videoPlayer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  TextEditingController myController = TextEditingController();
  bool showResults = false;
  List<RecentSearch> recentSearches = [];
  List<Video> videos = [];
  late RecentSearch obj;

  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  searchYoutube(String query) async {
    const apiKey = "AIzaSyCZB6jgkENt3fNy5PIY4LYGPJT5TfHn8XE";
    var url = "https://www.googleapis.com/youtube/v3/search"
        "?part=snippet"
        "&maxResults=15"
        "&q=$query"
        "&type=video"
        "&key=$apiKey";

    var response = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(response.body);

    setState(() {
      videos = decodedJson['items'].map<Video>((item) {
        return Video.fromJson(item);
      }).toList();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          flexibleSpace: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (showResults)
                      MaterialButton(
                        shape: CircleBorder(),
                        color: Colors.black,
                        padding: EdgeInsets.all(15.0),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            showResults = false;
                          });
                        },
                      ),
                    Container(
                      width: (showResults) ? 320 : 350,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 15),
                        child: TextField(
                          controller: myController,
                          style: TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                              hintText: "Search on Youtube",
                              hintStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 3,
                                color: Colors.black,
                              ))),
                          onSubmitted: (query) {
                            setState(() {
                              showResults = true;
                            });
                            searchYoutube(query);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                // Color(0xFF2E0530),
                // Color(0xFF200420),
                // Color(0xFF170316),
                // Color(0xFF060106),
                // Color(0xFF070107),
                // Color(0xFF1A031B),

                // Color(0xFF401141),
                // Color(0xFF3D113E),
                // Color(0xFF381139),
                // Color(0xFF2E0530),
                // Color(0xFF2B112C),
                // Color(0xFF261026),
                // Color(0xFF200420),
                // Color(0xFF1A0F1A),
                // Color(0xFF170316),
                // Color(0xFF060106),
                // Color(0xFF070107),

                Color(0xFF270070),
                Color(0xFF270183),
                Color(0xFF270082),
                Color(0xFF270065),
                Color(0xFF280048),
                Color(0xFF280047),
                Color(0xFF280047),
                Color(0xFF280047),
                Color(0xFF280047),

              ],
            ),
          ),
          child: (showResults)
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(videos[index].thumbnailUrl),
                      title: Text(videos[index].title),
                      subtitle: Text(videos[index].channelTitle),
                      onTap: () => {
                        recentSearches.add(RecentSearch(id: videos[index].id, title: videos[index].title, thumbnailUrl: videos[index].thumbnailUrl)),
                        print(
                            "##############################################################################################################################################################"),
                        print(videos[index].id),
                        print(videos[index].title),
                        print(videos[index].thumbnailUrl),
                        print(
                            "##############################################################################################################################################################"),
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen(
                              videoId: videos[index].id,
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
                      leading:
                          Image.network(recentSearches[index].thumbnailUrl),
                      title: Text(videos[index].title),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen(
                              videoId: recentSearches[index].id,
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
