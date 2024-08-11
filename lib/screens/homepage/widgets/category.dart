import 'package:flutter/material.dart';
import 'package:machine_test/model/category_model.dart';

class CategoryWiseProduct extends StatefulWidget {
  const CategoryWiseProduct({super.key});

  @override
  State<CategoryWiseProduct> createState() => _CategoryWiseProductState();
}

class _CategoryWiseProductState extends State<CategoryWiseProduct> {
  final List<Category> categories = [
    Category(imageUrl: 'assets/images/smartphone.png', name: 'Mobile'),
    Category(imageUrl: 'assets/images/smartphone.png', name: 'Laptop'),
    Category(imageUrl: 'assets/images/smartphone.png', name: 'Camera'),
    Category(imageUrl: 'assets/images/smartphone.png', name: 'LED'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 15),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                final category = categories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0), // Adjusted padding
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            category.imageUrl,
                            // fit: BoxFit.cover, // Ensures image covers the circle
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
