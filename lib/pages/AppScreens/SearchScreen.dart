import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../utils/API-Model.dart';
import '../../components/videoPlayer.dart';
import '../../components/inputFields.dart';
import '../../api_key.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  TextEditingController myController = TextEditingController();
  bool showResults = false;
  List<RecentSearch> recentSearches = [];
  // List<RecentSearch> recentSearches = [];
  List<Video> videos = [];

  searchYoutube(String query) async {
    var url = "https://www.googleapis.com/youtube/v3/search"
        "?part=snippet"
        "&maxResults=15"
        "&q=$query"
        "&type=video"
        "&key=$apiKey";

    var response = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(response.body);
    // print(url);
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
        toolbarHeight: 150,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (showResults)
                    MaterialButton(
                      shape: CircleBorder(),
                      color: Colors.orange,
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
                    width: (showResults) ? width*0.785 : width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 15),
                      child: SearchInputField(
                        myController: myController,
                        hintText: "What do you want to listen to?",
                        borderRadius: 5,
                        onSubmitted: (query) {
                          if(query != null){
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
              leading: Image.network(videos[index].thumbnailUrl),
              title: Text(videos[index].title),
              subtitle: Text(videos[index].channelTitle),
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.transparent),
              ),
              onTap: () => {
                recentSearches.add(RecentSearch(id: videos[index].id, title: videos[index].title, thumbnailUrl: videos[index].thumbnailUrl)),
                // print("##############################################################################################################################################################"),
                // print(videos[index].id),
                // print(videos[index].title),
                // print(videos[index].thumbnailUrl),
                // print("##############################################################################################################################################################"),
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
              leading:Image.network(recentSearches[index].thumbnailUrl),
              subtitle: null,
              title: Text(videos[index].title),
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.transparent),
              ),
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
