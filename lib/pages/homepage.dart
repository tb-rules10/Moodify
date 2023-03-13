import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('I am Rich'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: ListView(
          children: const <Widget>[
            Image(
              image: NetworkImage(
                  "https://www.investopedia.com/thmb/Z9hn3yJjTENp_e170q9z0c9ZpbM=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-83077314-31d4b4d009f443c8ac37ee30eec32800.jpg"),
            ),
            SizedBox(
              height: 25.0,
              width: 350.0,
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
            Image(
              image: NetworkImage(
                  "https://www.investopedia.com/thmb/Z9hn3yJjTENp_e170q9z0c9ZpbM=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-83077314-31d4b4d009f443c8ac37ee30eec32800.jpg"),
            ),SizedBox(
              height: 25.0,
              width: 350.0,
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
            Image(
              image: NetworkImage(
                  "https://www.investopedia.com/thmb/Z9hn3yJjTENp_e170q9z0c9ZpbM=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-83077314-31d4b4d009f443c8ac37ee30eec32800.jpg"),
            ),
          ],
        ),
      ),
    );
  }
}
