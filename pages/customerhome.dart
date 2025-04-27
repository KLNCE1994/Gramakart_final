import 'package:flutter/material.dart';
import 'myorderpage.dart';
import 'customerprofile.dart';
import 'package:newapp/widgets/cust_navbar.dart'; // Import your custom app bar
import 'package:newapp/widgets/custbot_nav.dart';
import 'package:newapp/widgets/prod_card.dart';
import 'package:newapp/widgets/business_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: const CustomerHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
      ),
    );
  }
}

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    const MyOrdersPage(),
    const HomeContentPage(),
    const ConsumerProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomerBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContentPage extends StatelessWidget {
  const HomeContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(height: 72), // ✅ Your custom app bar at the top

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Holi Sale Banner
                  Padding(
                    padding: const EdgeInsets.only(left:0, right: 0, top: 0, bottom: 35),
                    child: SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              'assets/images/banner.jpg',
                              fit: BoxFit.cover,
                            ),
 
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Businesses Near You
                  Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        "Businesses near you",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          textStyle: const TextStyle(fontSize: 12),
          minimumSize: const Size(40, 35)
        ),
        child: const Text("See More"),
      ),
    ],
  ),
),
const SizedBox(height: 10),

                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        BusinessCard(
                            name: "Uzhavan Mart",
                            category: "Agriculture",
                            location: "Madurai, TN",
                            imagePath: "assets/images/uzhavan_mart.jpg"),
                        BusinessCard(
                            name: "Rita's Touch",
                            category: "Handcrafts",
                            location: "Madurai, TN",
                            imagePath: "assets/images/rita.jpg"),
                        BusinessCard(
                            name: "Grandma Pickle",
                            category: "Foods",
                            location: "Madurai, TN",
                            imagePath: "assets/images/pickle.jpg"),
                      ],
                    ),
                    
                  ),
                  const SizedBox(height: 40,),
                  
                  // Recommendations
                                    Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        "Recommended for you",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          textStyle: const TextStyle(fontSize: 12),
          minimumSize: const Size(40, 35)
        ),
        child: const Text("See More"),
      ),
    ],
  ),
),
                  const SizedBox(height: 10),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        ProdCard(
                          imagePath: "assets/images/carrots.jpg",
                          title: "Organic Carrots",
                          price: "₹60/kg",
                          description:
                              "Freshly harvested carrots from local farms.",
                        ),
                        ProdCard(
                          imagePath: "assets/images/soap.jpg",
                          title: "Handcrafted Soap",
                          price: "₹120",
                          description:
                              "Natural ingredients with lavender scent.",
                        ),
                        ProdCard(
                          imagePath: "assets/images/Mpickle.jpg",
                          title: "Mango Pickle",
                          price: "₹90/jar",
                          description:
                              "Grandma’s homemade spicy mango pickle.",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

