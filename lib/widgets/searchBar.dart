import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final List<String> items; // List of items to be searched
  final Function(String) onSearch; 

  const SearchBarWidget({super.key, required this.items, required this.onSearch});

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  String _searchText = "";

  @override
  Widget build(BuildContext context) {
    List<String> filteredItems = widget.items
        .where((item) => item.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return Container(
      child: Column(
        children: [
          SizedBox(
            width: 300.0,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              onChanged: (text) {
                setState(() {
                  _searchText = text;
                });
                widget.onSearch(text); // Call onSearch callback with search text
              },
            ),
          ),
          if (filteredItems.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(filteredItems[index]),
                ),
              ),
            ),
          if (filteredItems.isEmpty) const Text('No results found'),
        ],
      ),
    );
  }
}

