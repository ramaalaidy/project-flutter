import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatefulWidget {
  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  int? _selectedMethodIndex;

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
        title: const Text('طرق الدفع'),
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: paymentMethods.length,
        itemBuilder: (context, index) {
          final method = paymentMethods[index];
          final isSelected = _selectedMethodIndex == index;
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: isSelected ? Colors.blue : Colors.transparent),
            ),
            elevation: isSelected ? 4 : 1,
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.blue : null,
                ),
              ),
              subtitle: Text(method['description']!),
              trailing: isSelected
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.chevron_left, color: Colors.grey),
              onTap: () {
                setState(() {
                  _selectedMethodIndex = index;
                });
                _showPaymentMethodDialog(context, method['title']!, method['description']!, index == _selectedMethodIndex);
              },
            ),
          );
        },
      ),
    );
  }

  void _showPaymentMethodDialog(BuildContext context, String title, String description, bool isSelected) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'هذه الطريقة مفعلة حالياً.',
                  style: TextStyle(color: Colors.green),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('إغلاق'),
          ),
          if (!isSelected)
            TextButton(
              onPressed: () {
                // يمكنك هنا تنفيذ إجراء لتغيير الطريقة المختارة
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$title تم اختيارها كطريقة دفع')),
                );
              },
              child: const Text('اختَر'),
            ),
        ],
      ),
    );
  }
}