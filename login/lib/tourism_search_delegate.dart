import 'package:flutter/material.dart';
import 'package:login/detail_screen.dart';

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
        : items.where((item) {
            final title = item['title'].toString().toLowerCase();
            final description = item['description'].toString().toLowerCase();
            final location = item['location'].toString().toLowerCase();
            return title.contains(query.toLowerCase()) ||
                description.contains(query.toLowerCase()) ||
                location.contains(query.toLowerCase());
          }).toList();

    if (searchResults.isEmpty) {
      return Center(
        child: Text('لا توجد نتائج للبحث'),
      );
    }

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
          trailing: item['price'] > 0
              ? Text('\$${item['price']}')
              : Text('مجاني', style: TextStyle(color: Colors.green)),
          onTap: () {
            // يمكنك هنا الذهاب لشاشة التفاصيل
            // showItemDetails(context, item);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(item: item),
              ),
            );
          },
        );
      },
    );
  }
}