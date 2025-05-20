import 'package:flutter/material.dart';

class CategoryItemsScreen extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;
  final Function(Map<String, dynamic>) onFavoriteToggle;

  const CategoryItemsScreen({
    Key? key,
    required this.title,
    required this.items,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.75,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.asset(
                        item['image'],
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['title'], style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text(item['location'], style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              if (item['price'] > 0)
                                Text('\$${item['price']}')
                              else
                                Text('Free', style: TextStyle(color: Colors.green)),
                              Spacer(),
                              Icon(Icons.chevron_right, color: Colors.blue),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}