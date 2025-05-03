import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingConfirmationPage extends StatelessWidget {
  final Map<String, dynamic> item;
  final Map<String, dynamic> bookingData;

  const BookingConfirmationPage({
    Key? key,
    required this.item,
    required this.bookingData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = bookingData['date'] != null
        ? bookingData['date'] as DateTime
        : DateTime.now();

    final formattedDate = DateFormat('dd/MM/yyyy').format(date);
    final people = bookingData['people'] ?? 1;
    final total = bookingData['total'] ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('تأكيد الحجز'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 100),
              SizedBox(height: 20),
              Text(
                'تم تأكيد حجزك بنجاح!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      rowText('التاريخ', formattedDate),
                      SizedBox(height: 10),
                      rowText('عدد الأشخاص', '$people'),
                      SizedBox(height: 10),
                      rowText('الإجمالي', '\$${total.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                label: Text('العودة'),
                style: ElevatedButton.styleFrom(
                  // primary: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowText(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
