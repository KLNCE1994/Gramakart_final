import 'package:flutter/material.dart';
import 'package:newapp/widgets/cust_navbar.dart';
import 'package:newapp/widgets/prod_card.dart';
//import 'package:newapp/widgets/business_card.dart';
import 'package:newapp/widgets/order_tile.dart';
import 'package:newapp/widgets/see_more_button.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(height: 100),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              sectionTitle("My Orders :"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Column(
                    children: [
                       OrderTile(
                        imagePath: 'assets/images/flower_vase.jpg',
                        title: 'Flower Vase',
                        subtitle: 'Arriving Today, 12PM',
                      ),
                       SizedBox(height: 8),
                       OrderTile(
                        imagePath: 'assets/images/Mpickle.jpg',
                        title: 'Mango Pickle',
                        subtitle: 'Arriving Tomorrow, 5PM',
                      ),
                       SizedBox(height: 12),
                       SeeMoreButton(),
                    ],
                  ),
                ),
              ),

              sectionTitle("My Cart:", fontSize:20),
              const Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:  [
                      ProdCard(
                        imagePath: "assets/images/carrots.jpg",
                        title: "Organic Carrots",
                        price: "₹60/kg",
                        description: "Freshly harvested carrots from local farms.",
                      ),
                      SizedBox(width: 10),
                      ProdCard(
                        imagePath: "assets/images/soap.jpg",
                        title: "Handcrafted Soap",
                        price: "₹120",
                        description: "Natural ingredients with lavender scent.",
                      ),
                      SizedBox(width: 10),
                      ProdCard(
                        imagePath: "assets/images/Mpickle.jpg",
                        title: "Mango Pickle",
                        price: "₹90/jar",
                        description: "Grandma’s homemade spicy mango pickle.",
                      ),
                    ],
                  ),
                ),
              ),
              const SeeMoreButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title, {double fontSize=20}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 30, 16, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style:  TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

