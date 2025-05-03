class Booking {
  final String id;
  final String itemImage;
  final String itemTitle;
  final DateTime bookingDate;
  final int guests;
  final String status;

  Booking({
    required this.id,
    required this.itemImage,
    required this.itemTitle,
    required this.bookingDate,
    required this.guests,
    required this.status,
  });
}
