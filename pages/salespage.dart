// lib/pages/salespage.dart
import 'package:flutter/material.dart';
import 'package:newapp/backend.dart';
import 'package:newapp/widgets/seller_navbar.dart';
import 'package:newapp/pages/scemespage.dart';
import 'package:newapp/pages/salesprofile.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../language_provider.dart'; // Import your LanguageProvider
//import '../widgets/language_dropdown.dart'; // Import the LanguageDropdown widget

class SalesPages extends StatefulWidget {
  final String docId;
  const SalesPages({super.key, required this.docId});
  @override
  State<SalesPages> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPages> {
  int _selectedIndex = 1;
  late final List<Widget> _pages;
  @override
  void initState() {
    super.initState();
    _pages = [
      SchemesPages(docId: widget.docId),
      SalesHomeContent(docId: widget.docId),
      SalesProfiles(docId: widget.docId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        items:  [
          BottomNavigationBarItem(icon: const Icon(Icons.local_offer), label: languageProvider.translate('Schemes',context)), // Removed translate here, handled in pages
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: languageProvider.translate('Home',context)), // Removed translate here, handled in pages
          BottomNavigationBarItem(icon: const Icon(Icons.person), label:languageProvider.translate('Profile',context) ), // Removed translate here, handled in pages
        ],
      ),
      floatingActionButton: _selectedIndex == 1 // Show FAB only on the HomeContent page
          ? FloatingActionButton(
              onPressed: () {
                // Add your FAB action here
                print('FAB clicked');
              },
              backgroundColor: Colors.orange,
              child: Image.asset(
          'assets/images/chatbot.png', // Replace with your image path
          width: 50, // Adjust width as needed
          height: 50, // Adjust height as needed
        ), // You can change the icon
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Default bottom right
    );
  }
}

class SalesHomeContent extends StatelessWidget {
  final String docId;
  const SalesHomeContent({super.key, required this.docId});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: FutureBuilder<Map<String, dynamic>>(
        future: Backend.fetchBusinessProfile(docId),
        builder: (ctx, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final data = snap.data!;
          final name = languageProvider.translate((data['businessName'] as String? ?? 'Seller'), context);
          final salesToday = languageProvider.translate((data['sales_today'] ?? '0'), context);
          final unitsToday = languageProvider.translate((data['units_today'] ?? '0'), context);
          final products = (data['products'] as List<dynamic>?) ?? [];
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const CircleAvatar(radius: 35, backgroundImage: AssetImage('assets/images/profile.png',),backgroundColor:Colors.white),
                    const SizedBox(width: 0),
                    Text(languageProvider.translate(name, context), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                  ]),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text(languageProvider.translate("My Dashboard:", context),
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                          const Spacer(),
                          const Icon(Icons.settings, size: 25),
                        ]),
                        const SizedBox(height: 16),
                        Row(children: [
                          _InfoCard(title: "${salesToday}rs", subtitle: languageProvider.translate("Sales today so far", context)),
                          const SizedBox(width: 16),
                          _InfoCard(title: unitsToday, subtitle: languageProvider.translate("Units today so far", context)),
                        ]),
                        const SizedBox(height: 20),
                        Text(languageProvider.translate("Product Sales", context),
                            style: const TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 10),
                        const SizedBox(height: 200, child: SalesBarChart()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(languageProvider.translate("My Products:", context),
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                  const SizedBox(height: 12),
                  for (var p in products)
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            p['imageUrl'] ?? 'https://via.placeholder.com/60',
                            height: 60, width: 60, fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(languageProvider.translate(p['name'] ?? 'Product', context), style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text("${p['total_units_sold'] ?? 0} units sold", style: const TextStyle(color: Colors.grey)),
                        ]),
                      ]),
                    ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                      child: Text(languageProvider.translate('+  Add Product', context)),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title, subtitle;
  const _InfoCard({required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)]),
        child: Column(children: [
          Text(
            languageProvider.translate(title, context),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            languageProvider.translate(subtitle, context),
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ]),
      ),
    );
  }
}

class SalesBarChart extends StatelessWidget {
  const SalesBarChart({super.key});
  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
      maxY: 10,
      minY: 0,
      barTouchData: BarTouchData(enabled: true),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, interval: 2, getTitlesWidget: (v, _) => Text(v.toInt().toString(), style: const TextStyle(fontSize: 12, color: Colors.grey)))),
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, _) {
          const days = ['Mon', 'Tue', 'Wed', 'Thu'];
          return Text(days[v.toInt()], style: const TextStyle(fontSize: 12, color: Colors.grey));
        })),
      ),
      gridData: FlGridData(show: true, drawHorizontalLine: true, horizontalInterval: 2, getDrawingHorizontalLine: (v) => FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1)),
      borderData: FlBorderData(show: false),
      barGroups: [
        BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 0, width: 18, color: Colors.orange)]),
        BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 0, width: 18, color: Colors.deepOrange)]),
        BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 0, width: 18, color: Colors.amber)]),
        BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 0, width: 18, color: Colors.orangeAccent)]),
      ],
    ));
  }
}