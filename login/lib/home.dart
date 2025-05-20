import 'package:flutter/material.dart';
import 'package:login/Profile.Screen.dart';
import 'package:login/booking.page.dart';

// import 'package:flutter_svg/flutter_svg.dart';

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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;
  final List<String> categories = [
    'All',
    'Hotels',
    'Restaurants',
    'Activities',
    'Shopping',
    'Transportation',
  ];

  // Banner variables
  final PageController _bannerController = PageController();
  int _currentBanner = 0;
  final List<String> banners = [
    'assets/images/3.jpg', // Using existing images from your assets
    'assets/images/17.jpeg',
    'assets/images/IMG_9421.jpg',
  ];

  final List<Map<String, dynamic>> featuredItems = [
    {
      'title': 'Luxury Beach Resort',
      'image': 'assets/images/3.jpg',
      'price': 200,
      'rating': 4.8,
      'type': 'Hotels',
      'description': '5-star resort with private beach and spa facilities',
      'location': 'Aqaba Beach',
      'isFavorite': false,
    },
    {
      'title': 'Red Sea Diving',
      'image': 'assets/images/17.jpeg',
      'price': 75,
      'rating': 4.9,
      'type': 'Activities',
      'description': 'Explore the beautiful coral reefs of the Red Sea',
      'location': 'Red Sea',
      'isFavorite': true,
    },
    {
      'title': 'Seafood Restaurant',
      'image': 'assets/images/fish.jpg',
      'price': 40,
      'rating': 4.5,
      'type': 'Restaurants',
      'description': 'Fresh seafood with stunning sea views',
      'location': 'Aqaba Marina',
      'isFavorite': false,
    },
    {
      'title': 'Wadi Rum Tour',
      'image': 'assets/images/IMG_9421.jpg',
      'price': 120,
      'rating': 4.7,
      'type': 'Activities',
      'description': 'Full-day tour to the majestic Wadi Rum desert',
      'location': 'Wadi Rum',
      'isFavorite': true,
    },
    {
      'title': 'Souvenir Market',
      'image': 'assets/images/1182728b0d17d4a20f5c7c4e22709b30.jpg',
      'price': 0,
      'rating': 4.3,
      'type': 'Shopping',
      'description': 'Traditional Jordanian crafts and souvenirs',
      'location': 'City Center',
      'isFavorite': false,
    },
    {
      'title': 'Premium Transportation',
      'image': 'assets/images/taxxx.jpg',
      'price': 150,
      'rating': 4.8,
      'type': 'Transportation',
      'description': 'Luxury vehicles with professional drivers',
      'location': 'Citywide',
      'isFavorite': false,
    },
  ];

  // Filter variables
  RangeValues _priceRange = RangeValues(0, 250);
  double _minRating = 4.0;
  bool _showFavoritesOnly = false;

  @override
  void initState() {
    super.initState();
    // Auto-scroll banners
    _startBannerTimer();
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  void _startBannerTimer() {
    Future.delayed(Duration(seconds: 5), () {
      if (_bannerController.hasClients) {
        int nextPage = _currentBanner + 1;
        if (nextPage >= banners.length) {
          nextPage = 0;
        }
        _bannerController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _startBannerTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildCategories(),
            _buildFilterSection(),
            _buildFeaturedSection(),
            _buildPopularSection(),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Hero(
            tag: 'app-logo',
            child: Image.asset('assets/images/AQ.png', width: 40, height: 40),
          ),
          SizedBox(width: 10),
          Text(
            'Aqaba Explorer',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
      centerTitle: true,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: TourismSearchDelegate(featuredItems),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () => _showFilterDialog(context),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          PageView.builder(
            controller: _bannerController,
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentBanner = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                banners[index],
                fit: BoxFit.cover,
                width: double.infinity,
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  banners.map((url) {
                    int index = banners.indexOf(url);
                    return Container(
                      width: 8,
                      height: 8,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentBanner == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                      ),
                    );
                  }).toList(),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover Aqaba',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'The Red Sea Gem of Jordan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = index;
              });
            },
            child: Container(
              width: 100,
              margin: EdgeInsets.only(left: index == 0 ? 15 : 0, right: 10),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color:
                          _selectedCategory == index
                              ? Colors.blue
                              : Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      _getCategoryIcon(categories[index]),
                      color:
                          _selectedCategory == index
                              ? Colors.white
                              : Colors.blue,
                      size: 30,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    categories[index],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          _selectedCategory == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Hotels':
        return Icons.hotel;
      case 'Restaurants':
        return Icons.restaurant;
      case 'Activities':
        return Icons.directions_bike;
      case 'Shopping':
        return Icons.shopping_bag;
      case 'Transportation':
        return Icons.directions_car;
      default:
        return Icons.explore;
    }
  }

  Widget _buildFilterSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          FilterChip(
            label: Text('Favorites'),
            selected: _showFavoritesOnly,
            onSelected: (selected) {
              setState(() {
                _showFavoritesOnly = selected;
              });
            },
            selectedColor: Colors.blue,
            checkmarkColor: Colors.white,
            labelStyle: TextStyle(
              color: _showFavoritesOnly ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(width: 10),
          FilterChip(
            label: Text('Rating ${_minRating}+'),
            selected: _minRating > 0,
            onSelected: (selected) {
              setState(() {
                _minRating = selected ? 4.0 : 0;
              });
            },
            selectedColor: Colors.blue,
            checkmarkColor: Colors.white,
            labelStyle: TextStyle(
              color: _minRating > 0 ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection() {
    List<Map<String, dynamic>> filteredItems = _getFilteredItems();

    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedCategory == 0
                    ? 'Featured'
                    : categories[_selectedCategory],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              if (filteredItems.length > 4)
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => CategoryItemsScreen(
                              title: categories[_selectedCategory],
                              items: filteredItems,
                              onFavoriteToggle: _toggleFavorite,
                            ),
                      ),
                    );
                  },
                  child: Text('See All'),
                ),
            ],
          ),
          SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
              double childAspectRatio =
                  constraints.maxWidth > 600 ? 0.85 : 0.75;

              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: filteredItems.length > 6 ? 6 : filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return _buildItemCard(item);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPopularSection() {
    final popularActivities =
        featuredItems.where((item) => item['type'] == 'Activities').toList();

    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Activities',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularActivities.length,
              itemBuilder: (context, index) {
                final activity = popularActivities[index];
                return Container(
                  width: 300,
                  margin: EdgeInsets.only(right: 15),
                  child: _buildActivityCard(activity),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          _showItemDetails(context, item);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(
                    item['image'],
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      item['isFavorite']
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: item['isFavorite'] ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      _toggleFavorite(item);
                    },
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '${item['rating']}',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    item['location'],
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      if (item['price'] > 0)
                        Text(
                          'From \$${item['price']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // color: Colors.blue,
                          ),
                        )
                      else
                        Text(
                          'Free',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      Spacer(),
                      Icon(Icons.chevron_right, color: Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          _showItemDetails(context, activity);
        },
        child: Stack(
          children: [
            // ... (keep all your existing stack children)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ... (keep other content)
                    SizedBox(height: 10),
                    Row(
                      children: [
                        if (activity['price'] > 0)
                          Text(
                            '\$${activity['price']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        else
                          Text(
                            'Free',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => BookingPage(item: activity),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Book Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Filter Options'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Price Range: \$${_priceRange.start.round()} - \$${_priceRange.end.round()}',
                    ),
                    RangeSlider(
                      values: _priceRange,
                      min: 0,
                      max: 250,
                      divisions: 10,
                      labels: RangeLabels(
                        '\$${_priceRange.start.round()}',
                        '\$${_priceRange.end.round()}',
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _priceRange = values;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text('Minimum Rating: ${_minRating.toStringAsFixed(1)}'),
                    Slider(
                      value: _minRating,
                      min: 0,
                      max: 5,
                      divisions: 10,
                      label: _minRating.toStringAsFixed(1),
                      onChanged: (value) {
                        setState(() {
                          _minRating = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: _showFavoritesOnly,
                          onChanged: (value) {
                            setState(() {
                              _showFavoritesOnly = value!;
                            });
                          },
                        ),
                        Text('Show Favorites Only'),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      // Apply filters
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showItemDetails(BuildContext context, Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ... (keep all your existing content)
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Close the bottom sheet
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingPage(item: item),
                        ),
                      );
                    },
                    child: Text('Book Now', style: TextStyle(fontSize: 18)),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void _toggleFavorite(Map<String, dynamic> item) {
    setState(() {
      item['isFavorite'] = !item['isFavorite'];
    });
  }

  List<Map<String, dynamic>> _getFilteredItems() {
    List<Map<String, dynamic>> filteredItems =
        _selectedCategory == 0
            ? List.from(featuredItems)
            : featuredItems
                .where((item) => item['type'] == categories[_selectedCategory])
                .toList();

    // Apply price filter
    filteredItems =
        filteredItems
            .where(
              (item) =>
                  item['price'] >= _priceRange.start &&
                  item['price'] <= _priceRange.end,
            )
            .toList();

    // Apply rating filter
    if (_minRating > 0) {
      filteredItems =
          filteredItems.where((item) => item['rating'] >= _minRating).toList();
    }

    // Apply favorites filter
    if (_showFavoritesOnly) {
      filteredItems =
          filteredItems.where((item) => item['isFavorite']).toList();
    }

    return filteredItems;
  }
}

class CategoryItemsScreen extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;
  final Function(Map<String, dynamic>) onFavoriteToggle;

  const CategoryItemsScreen({
    required this.title,
    required this.items,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.75,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return _buildItemCard(item, context);
          },
        ),
      ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item, BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          _showItemDetails(context, item);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(
                    item['image'],
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      item['isFavorite']
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: item['isFavorite'] ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      onFavoriteToggle(item);
                    },
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '${item['rating']}',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    item['location'],
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      if (item['price'] > 0)
                        Text(
                          'From \$${item['price']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        )
                      else
                        Text(
                          'Free',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      Spacer(),
                      Icon(Icons.chevron_right, color: Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showItemDetails(BuildContext context, Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 60,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        item['image'],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        icon: Icon(
                          item['isFavorite']
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: item['isFavorite'] ? Colors.red : Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          onFavoriteToggle(item);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  item['title'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.blue),
                    SizedBox(width: 5),
                    Text(
                      item['location'],
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    Spacer(),
                    Icon(Icons.star, color: Colors.amber),
                    SizedBox(width: 5),
                    Text(
                      '${item['rating']}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Description',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  item['description'],
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 20),
                if (item['price'] > 0)
                  Text(
                    'From \$${item['price']} per person',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  )
                else
                  Text(
                    'Free Entry',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Text('Book Now', style: TextStyle(fontSize: 18)),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TourismSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> items;

  TourismSearchDelegate(this.items);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final List<Map<String, dynamic>> searchResults =
        query.isEmpty
            ? items
            : items
                .where(
                  (item) =>
                      item['title'].toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      item['description'].toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      item['location'].toLowerCase().contains(
                        query.toLowerCase(),
                      ),
                )
                .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final item = searchResults[index];
        return ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage(item['image'])),
          title: Text(item['title']),
          subtitle: Text(item['location']),
          trailing: Text('\$${item['price']}'),
          onTap: () {
            close(context, item);
          },
        );
      },
    );
  }
}

class _MainScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(), // تأكد أن HomeScreen لا يحتوي على Scaffold
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
