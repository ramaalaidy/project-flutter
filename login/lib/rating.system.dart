import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _rating = 3.5;

    return Scaffold(
      appBar: AppBar(title: Text('قيّم تجربتك')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('كيف تقيم هذا العنصر؟'),
            SizedBox(height: 20),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40,
              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                _rating = rating;
                // يمكنك استخدام RatingSystem.submitRating هنا
              },
            ),
          ],
        ),
      ),
    );
  }
}

