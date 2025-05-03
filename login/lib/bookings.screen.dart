import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'booking.provider.dart';
import 'booking.model.dart';

class BookingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('حجوزاتي'),
      ),
      body: bookingProvider.bookings.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_note, size: 60, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('لا توجد حجوزات بعد'),
                  SizedBox(height: 8),
                  Text('قم بحجز الخدمات التي تريدها من المتجر'),
                ],
              ),
            )
          : ListView.builder(
              itemCount: bookingProvider.bookings.length,
              itemBuilder: (context, index) {
                final booking = bookingProvider.bookings[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        booking.itemImage,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.image_not_supported),
                      ),
                    ),
                    title: Text(booking.itemTitle),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('التاريخ: ${booking.bookingDate.day}/${booking.bookingDate.month}/${booking.bookingDate.year}'),
                        Text('عدد الأشخاص: ${booking.guests}'),
                        Text('الحالة: ${booking.status}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.cancel, color: Colors.red),
                      onPressed: () {
                        bookingProvider.cancelBooking(booking.id);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
