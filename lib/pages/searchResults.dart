import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  String query = "Machayenge";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
      Row(
      crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: true,
            child: Container(
              child: MaterialButton(
                child: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(
            height: 100,
            width: 250,
            child: TextField(
              controller: TextEditingController(),
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
              onSubmitted: (query) {},
            ),
          ),
        ],
      )
          ,
          Row(
            children: <Widget>[
              Icon(Icons.arrow_back),
              Text(
                "Search Results for $query",
                style: TextStyle(
                    fontSize: .0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Pacifico"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
