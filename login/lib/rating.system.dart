import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _rating = 3.5;

    return Scaffold(
      appBar: AppBar(title: const Text('قيّم تجربتك')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'كيف تقيم هذا العنصر؟',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                _rating = rating;
                // يمكنك هنا استدعاء دالة لإرسال التقييم للسيرفر
                // مثال: RatingSystem.submitRating(rating);
              },
            ),
            const SizedBox(height: 20),
            Text(
              'التقييم الحالي: $_rating',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                // يمكنك هنا حفظ التقييم في قاعدة بيانات أو إظهار رسالة
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('تم حفظ التقييم: $_rating ⭐')),
                );
              },
              icon: const Icon(Icons.save),
              label: const Text('حفظ التقييم'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}