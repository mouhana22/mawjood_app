import 'package:flutter/material.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  var employees = [];
  var items = [];
  final TextEditingController SearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SearchController.addListener(queryListener);
  } 

  @override
  void dispose() {
    SearchController.removeListener(queryListener);
    SearchController.dispose();
    super.dispose();
  }

  void queryListener() {
    search(SearchController.text);
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        items = employees;
      });
    } else {
      setState(() {
        items = employees
            .where((e) => e.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 16.0,
                ),
                SearchBar(
                  controller: SearchController,
                  leading: const Icon(Icons.search),
                  hintText: 'search...',
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount:
                          items.isEmpty ? employees.length : items.length,
                      itemBuilder: (context, index) {
                        final item =
                            items.isEmpty ? employees[index] : items[index];

                        return Card(
                          child: Column(
                            children: [
                              Text('Name: $item'),
                              const SizedBox(
                                height: 8.0,),
                              Text(item),
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      );
  }
}