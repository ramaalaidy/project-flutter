import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // لاستيراد DateFormat

void main() {
  runApp(MaterialApp(home: BookingHistoryScreen()));
}

class BookingSystem {
  static Future<bool> bookItem({
    required Map<String, dynamic> item,
    required DateTime date,
    required int guests,
    String? specialRequests,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }

  static Future<List<Map<String, dynamic>>> getBookingHistory() async {
    return [
      {
        'id': '12345',
        'item': {'title': 'Luxury Beach Resort', 'image': 'assets/hotel1.jpg'},
        'date': '2023-10-15',
        'status': 'Confirmed',
      },
      {
        'id': '67890',
        'item': {'title': 'Red Sea Diving', 'image': 'assets/diving.jpg'},
        'date': '2023-11-20',
        'status': 'Completed',
      },
    ];
  }

  static Future<bool> deleteBooking(String bookingId) async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }
}

class BookingHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking History')),
      body: FutureBuilder<List<Map<String, dynamic>>>( // إظهار بيانات الحجوزات
        future: BookingSystem.getBookingHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading bookings'));
          }

          final bookings = snapshot.data ?? [];

          if (bookings.isEmpty) {
            return const Center(child: Text('No bookings yet'));
          }

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: _buildImage(booking['item']['image']),
                  title: Text(booking['item']['title']),
                  subtitle: Text(
                    'Date: ${_formatDate(booking['date'])}\nStatus: ${booking['status']}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          final confirmed = await showDeleteDialog(
                            context,
                            booking['id'],
                          );
                          if (confirmed) {
                            bool success = await BookingSystem.deleteBooking(
                              booking['id'],
                            );
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Booking deleted successfully'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to delete booking'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () {
                    _showBookingDetails(context, booking);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  // بناء الصورة التي يتم عرضها
  Widget _buildImage(String imagePath) {
    return Image.asset(
      imagePath,
      width: 60,
      height: 60,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.image_not_supported, size: 60); // صورة افتراضية في حال فشل تحميل الصورة
      },
    );
  }

  // تنسيق التاريخ
  String _formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  // عرض تفاصيل الحجز
  void _showBookingDetails(BuildContext context, Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(booking['item']['title']),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date: ${_formatDate(booking['date'])}'),
              Text('Status: ${booking['status']}'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  // حوار تأكيد الحذف
  Future<bool> showDeleteDialog(BuildContext context, String bookingId) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text('Delete Booking'),
              content: const Text('Are you sure you want to delete this booking?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
