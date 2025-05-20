import 'package:flutter/material.dart';

class TourismSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> items;

  TourismSearchDelegate(this.items);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final List<Map<String, dynamic>> searchResults = query.isEmpty
        ? items
        : items.where((item) =>
            item['title'].toLowerCase().contains(query.toLowerCase()) ||
            item['description'].toLowerCase().contains(query.toLowerCase()) ||
            item['location'].toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final item = searchResults[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(item['image']),
          ),
          title: Text(item['title']),
          subtitle: Text(item['location']),
          trailing: Text('\$${item['price']}'),
          onTap: () {
            close(context, item);
          },
        );
      },
    );
  }
}