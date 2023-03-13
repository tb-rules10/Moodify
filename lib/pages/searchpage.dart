import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:demo_music/constants.dart';
import 'package:demo_music/videoPlayer.dart';

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
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              if (showResults)
                Container(
                  height: 60,
                  color: Colors.green,
                  child: MaterialButton(
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                    onPressed: () {
                      setState(() {
                        showResults = false;
                      });
                    },
                  ),
                ),
              Container(
                width: 280,
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    hintText: "Search on Youtube",
                    fillColor: Colors.black,
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        width: 5,
                        color: Colors.black,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  onSubmitted: (query) {
                    setState(() {
                      showResults = true;
                    });
                    searchYoutube(query);
                  },
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            child: Text(
              (showResults) ? "Search Results" : "Recent Searches",
              style: const TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
              ),
            ),
          ),

          (showResults) ?
          ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(videos[index].thumbnailUrl),
                      title: Text(videos[index].title),
                      subtitle: Text(videos[index].channelTitle),
                      onTap: () => {
                        recentSearches.add(RecentSearch(
                            id: videos[index].id,
                            title: videos[index].title,
                            thumbnailUrl: videos[index].thumbnailUrl)),
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
        ],
      ),
    );
  }
}
