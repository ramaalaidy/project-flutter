import 'package:flutter/material.dart';

// استيراد الصفحات والكلاسات
import 'package:login/PaymentMethodsScreen.dart';
import 'welcome.page.dart';
import 'signup.dart';
import 'login.dart';
import 'home.dart';
import 'splash.screen.dart';
import 'map.screen.dart';
import 'main_screen.dart'; // MainScreen - تحتوي على BottomNavigationBar
import 'booking.provider.dart';
import 'booking.page.dart';
import 'booking.confirmation.page.dart';
import 'booking.model.dart';
import 'bookings.screen.dart';
import 'Detail.Page.dart';
import 'FavoritesPage.dart';
import 'Profile.Screen.dart';
import 'rating.system.dart';

void main() {
  runApp(AqabaTourismApp());
}

class AqabaTourismApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aqaba Tourism',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/splash', // الصفحة الرئيسية مع Bottom Navigation Bar
      routes: {
        '/booking':
            (context) => BookingPage(
              item: {
                'title': 'شاطئ العقبة',
                'price': 100,
                'image': 'assets/beach.jpg',
                'rating': 4.5,
                'location': 'العقبة',
              },
            ),
        '/bookings_screen': (context) => BookingsScreen(),
        '/signup': (context) => Signup(),
        '/login': (context) => Login(),
        '/home': (context) => MainScreen(),
        '/favorites': (context) => FavoritesPage(),
        '/profile': (context) => ProfileScreen(),
        '/rating': (context) => RatingPage(),
        '/splash': (context) => SplashScreen(),
        '/welcome': (context) => WelcomePage(),
        '/map': (context) => MapScreen(locations: aqabaLocations),
        '/payment_methods': (context) => PaymentMethodsScreen(),
      },
    );
  }
}
