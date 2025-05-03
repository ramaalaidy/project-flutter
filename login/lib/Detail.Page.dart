import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final Map<String, dynamic> item = args is Map<String, dynamic> ? args : {};

    if (item.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('No details available for this item.')),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                item['image'] ?? 'assets/images/AQ.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] ?? 'No Title',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue),
                      SizedBox(width: 5),
                      Text(item['location'] ?? 'No location provided'),
                      Spacer(),
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 5),
                      Text('${item['rating'] ?? 0}'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(item['description'] ?? 'No description available'),
                  SizedBox(height: 20),
                  if (item['type'] == 'Hotels') _buildHotelFacilities(),
                  if (item['type'] == 'Activities') _buildActivityDetails(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelFacilities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Facilities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('• Free WiFi\n• Swimming Pool\n• Spa\n• Breakfast Included'),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildActivityDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Activity Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('• Duration: 2 hours\n• Equipment provided\n• Guide included'),
        SizedBox(height: 20),
      ],
    );
  }
}
