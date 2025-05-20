import 'package:flutter/material.dart';
import 'package:login/FavoritesPage.dart';
import 'package:login/PaymentMethodsScreen.dart';
import 'package:login/booking.system.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "Rama";
  String userEmail = "rama@example.com";
  String userImage = 'assets/images/AQ.png';
  String userPhone = "+962 7XXX XXXX";
  String userAddress = "العقبة، الأردن";

  void _updateUserProfile(String newName, String newEmail, String newImage) {
    setState(() {
      userName = newName;
      userEmail = newEmail;
      userImage = newImage;
    });
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعديل الصورة الشخصية'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('التقاط صورة'),
              onTap: () {
                // يمكنك هنا ربطها مع Camera plugin لاحقاً
                Navigator.pop(context);
                _updateUserProfile( "New Name", "new@email.com", "assets/images/AQ.png");
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('اختيار من المعرض'),
              onTap: () {
                // يمكنك هنا ربطها مع Image Picker لاحقاً
                Navigator.pop(context);
                _updateUserProfile( "User New", "user_new@example.com", "assets/images/AQ.png");
              },
            ),
          ],
        ),
      ),
    );
  }

  void updateUserProfile(BuildContext context, String name, String email, String image) {
    // هذه الدالة لتحديث البيانات - يمكن استبدالها بمصدر بيانات حقيقي لاحقاً
    setState(() {
      userName = name;
      userEmail = email;
      userImage = image;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$name تم تحديث البيانات')),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, Color color, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      elevation: 1,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_left, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: const Icon(Icons.logout, color: Colors.red),
        label: const Text('تسجيل الخروج', style: TextStyle(color: Colors.red)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          side: BorderSide(color: Colors.red.withOpacity(0.3)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () => _showLogoutConfirmation(context),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد تسجيل الخروج'),
        content: const Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
        actions: [
          TextButton(
            child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
            onPressed: Navigator.of(context).pop,
          ),
          TextButton(
            child: const Text('تسجيل الخروج', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم تسجيل الخروج بنجاح'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                userImage,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.3),
                colorBlendMode: BlendMode.darken,
              ),
              title: const Text(
                'الحساب',
                style: TextStyle(
                  color: Colors.white,
                  shadows: [
                    Shadow(blurRadius: 10, color: Colors.black, offset: Offset(1, 1)),
                  ],
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue, width: 3),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(userImage),
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white, size: 18),
                          onPressed: () => _showEditProfileDialog(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(userName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(userEmail, style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                  const SizedBox(height: 10),
                  Text(userPhone, style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                  const SizedBox(height: 10),
                  Text(userAddress, style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                  const SizedBox(height: 30),
                  _buildProfileOption(
                    Icons.history,
                    'سجل الحجوزات',
                    Colors.blue,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => BookingHistoryScreen()),
                    ),
                  ),
                  _buildProfileOption(
                    Icons.favorite_border,
                    'المفضلة',
                    Colors.red,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => FavoritesPage()),
                    ),
                  ),
                  _buildProfileOption(
                    Icons.credit_card,
                    'طرق الدفع',
                    Colors.purple,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PaymentMethodsScreen()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  _buildLogoutButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}