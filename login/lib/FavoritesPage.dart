import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  // مثال على قائمة العناصر المفضلة
  final List<String> favoriteItems = [
    'فندق البحر الأحمر',
    'مقهى الكورنيش',
    'مغامرة في وادي رم',
    'شاطئ العقبة',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المفضلة'),
      ),
      body: favoriteItems.isEmpty
          ? const Center(child: Text('لا يوجد عناصر مفضلة حالياً'))
          : ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favoriteItems[index]),
                  trailing: const Icon(Icons.favorite, color: Colors.red),
                  onTap: () {
                    // إضافة كود للمزيد من التفاصيل أو الإجراءات عند النقر
                    _showDetails(context, favoriteItems[index]);
                  },
                );
              },
            ),
    );
  }

  // دالة لعرض تفاصيل العنصر عند النقر عليه
  void _showDetails(BuildContext context, String item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(item),
          content: Text('تفاصيل عن $item'),
          actions: [
            TextButton(
              child: const Text('إغلاق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
