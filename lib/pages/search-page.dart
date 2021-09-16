import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchText = TextEditingController(text: "");
  List<AlgoliaObjectSnapshot> _results = [];
  bool _searching = false;

  _search() async {
    setState(() {
      _searching = true;
    });

    Algolia algolia = Algolia.init(
      applicationId: 'APP_ID',
      apiKey: 'SEARCH_API_KEY',
    );

    AlgoliaQuery query = algolia.instance.index('Posts');
    query = query.search(_searchText.text);

    _results = (await query.getObjects()).hits;

    setState(() {
      _searching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Search"),
          TextField(
            controller: _searchText,
            decoration: InputDecoration(hintText: "Search query here..."),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                style: ButtonStyle(),
                child: Text(
                  "Search",
                  style: TextStyle(),
                ),
                onPressed: _search,
              ),
            ],
          ),
          Expanded(
            child: _searching == true
                ? Center(
              child: Text("Searching, please wait..."),
            )
                : _results.length == 0
                ? Center(
              child: Text("No results found."),
            )
                : ListView.builder(
              itemCount: _results.length,
              itemBuilder: (BuildContext ctx, int index) {
                AlgoliaObjectSnapshot snap = _results[index];

                return ListTile(
                  leading: CircleAvatar(
                    child: Text(      (index + 1).toString(),
                    ),
                  ),
                  title: Text(snap.data["post_tit"]),
                  subtitle: Text(snap.data["post_text"]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
