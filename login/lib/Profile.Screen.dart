import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String userName = "Rama";
  final String userEmail = "rama@example.com";
  final String userImage = 'assets/images/AQ.png';
  final String userPhone = "+962 7XXX XXXX";
  final String userAddress = "العقبة، الأردن";

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
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black,
                      offset: Offset(1, 1),
                    ),
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
                          border: Border.all(
                            color: Colors.blue,
                            width: 3,
                          ),
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
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    userEmail,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userPhone,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userAddress,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildProfileOption(
                    Icons.history,
                    'سجل الحجوزات',
                    Colors.blue,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingHistoryScreen()),
                    ),
                  ),
                  _buildProfileOption(
                    Icons.favorite_border,
                    'المفضلة',
                    Colors.red,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoritesScreen()),
                    ),
                  ),
                  _buildProfileOption(
                    Icons.credit_card,
                    'طرق الدفع',
                    Colors.purple,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentMethodsScreen()),
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
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
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
        label: const Text(
          'تسجيل الخروج',
          style: TextStyle(color: Colors.red),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          side: BorderSide(color: Colors.red.withOpacity(0.3)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
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
            onPressed: () => Navigator.pop(context),
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
                // كود فتح الكاميرا
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('اختيار من المعرض'),
              onTap: () {
                // كود فتح المعرض
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// سجل الحجوزات
class BookingHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سجل الحجوزات')),
      body: const Center(child: Text('تفاصيل الحجوزات هنا')),
    );
  }
}

// المفضلة
class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المفضلة')),
      body: const Center(child: Text('لا يوجد عناصر مفضلة حالياً')),
    );
  }
}

// طرق الدفع
class PaymentMethodsScreen extends StatelessWidget {
  final List<Map<String, String>> paymentMethods = [
    {
      'title': 'بطاقة الائتمان',
      'description': 'أضف بطاقة ائتمانك لتسهيل عمليات الدفع.',
      'icon': 'assets/icons/credit_card.png',
    },
    {
      'title': 'بايبال',
      'description': 'استخدم حساب بايبال للدفع عبر الإنترنت.',
      'icon': 'assets/icons/paypal.png',
    },
    {
      'title': 'الدفع النقدي',
      'description': 'دفع نقدي عند الوصول.',
      'icon': 'assets/icons/cash.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('طرق الدفع')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: paymentMethods.length,
        itemBuilder: (context, index) {
          final method = paymentMethods[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Image.asset(
                method['icon']!,
                width: 40,
                height: 40,
              ),
              title: Text(method['title']!),
              subtitle: Text(method['description']!),
              trailing: const Icon(Icons.chevron_left),
              onTap: () {
                // معالجة اختيار طريقة الدفع
              },
            ),
          );
        },
      ),
    );
  }
}
