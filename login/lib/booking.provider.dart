import 'package:flutter/material.dart';
import 'booking.model.dart';

class BookingProvider extends ChangeNotifier {
  List<Booking> _bookings = [];

  List<Booking> get bookings => _bookings;

  // إضافة حجز جديد
  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners();
  }

  // إلغاء حجز
  void cancelBooking(String id) {
    _bookings.removeWhere((booking) => booking.id == id);
    notifyListeners();
  }
}
