import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatelessWidget {
  final List<Map<String, String>> paymentMethods = [
    {
      'title': 'بطاقة الائتمان',
      'description': 'أضف بطاقة ائتمانك لتسهيل عمليات الدفع.',
      'image': 'assets/images/black.png',
    },
    {
      'title': 'بايبال',
      'description': 'استخدم حساب بايبال للدفع عبر الإنترنت.',
      'image': 'assets/images/paypal.png',
    },
    {
      'title': 'الدفع النقدي',
      'description': 'دفع نقدي عند الوصول.',
      'image': 'assets/images/many.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('طرق الدفع'),
      ),
      body: ListView.builder(
        itemCount: paymentMethods.length,
        itemBuilder: (context, index) {
          final method = paymentMethods[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  method['image']!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                method['title']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(method['description']!),
              onTap: () {
                _showPaymentMethodDialog(context, method['title']!, method['description']!);
              },
            ),
          );
        },
      ),
    );
  }

  void _showPaymentMethodDialog(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            child: Text('إغلاق'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
