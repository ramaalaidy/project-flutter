import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // استيراد مكتبة التنسيق

class BookingPage extends StatefulWidget {
  final Map<String, dynamic> item;

  const BookingPage({Key? key, required this.item}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // متغيرات لتخزين بيانات الحجز
  DateTime? _selectedDate;
  int _peopleCount = 1;
  double _totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _totalAmount = widget.item['price'] ?? 0.0;
  }

  // دالة لاختيار التاريخ
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  // دالة لحساب الإجمالي بناءً على عدد الأشخاص
  void _calculateTotal() {
    setState(() {
      _totalAmount = widget.item['price'] * _peopleCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('صفحة الحجز')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عرض تفاصيل العنصر (شاطئ العقبة)
            Text(
              widget.item['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Image.asset(
              widget.item['image'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            // اختيار التاريخ
            Text(
              'اختر تاريخ الحجز:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  _selectedDate == null
                      ? 'لم يتم اختيار تاريخ'
                      : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
            SizedBox(height: 20),
            // اختيار عدد الأشخاص
            Text(
              'عدد الأشخاص:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _peopleCount.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: _peopleCount.toString(),
              onChanged: (value) {
                setState(() {
                  _peopleCount = value.toInt();
                });
                _calculateTotal();
              },
            ),
            Text('عدد الأشخاص: $_peopleCount', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            // عرض الإجمالي
            Text(
              'الإجمالي:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('\$${_totalAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            // زر تأكيد الحجز
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedDate != null) {
                    Navigator.pushNamed(
                      context,
                      '/bookingConfirmation',
                      arguments: {
                        'item': widget.item,
                        'bookingData': {
                          'date': _selectedDate,
                          'people': _peopleCount,
                          'total': _totalAmount,
                        },
                      },
                    );
                  } else {
                    // عرض رسالة تنبيه في حال لم يتم اختيار تاريخ
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('تحذير'),
                        content: Text('يرجى اختيار تاريخ للحجز أولاً'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('حسنًا'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('تأكيد الحجز'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
