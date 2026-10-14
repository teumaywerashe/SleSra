import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:silesra/Dataprovider/Models.dart';
import 'package:silesra/models/product_model.dart';
import 'package:silesra/widgets/PropertyCard.dart';
import 'package:silesra/widgets/custom_bottom_navigation.dart';
import '../Dataprovider/listing_provider.dart';
import 'search_and_filter_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String selectedCategory = '';

  final List<CategoryHome> _categories = [
    CategoryHome(
        name: 'Houses', api: 'house', icon: Icons.home, color: Colors.blue),
    CategoryHome(
        name: 'Cars',
        api: 'car',
        icon: Icons.directions_car,
        color: Colors.red),
    CategoryHome(
        name: 'Others',
        api: 'others',
        icon: Icons.category,
        color: Colors.purple),
    CategoryHome(
        name: 'Jobs', api: 'jobs', icon: Icons.work, color: Colors.orange),
    CategoryHome(
        name: 'Sponsored',
        api: 'sponsored',
        icon: Icons.star,
        color: Colors.yellow),
    CategoryHome(
        name: 'Services',
        api: 'services',
        icon: Icons.design_services,
        color: Colors.green),
    CategoryHome(
        name: 'Wanted', api: 'wanted', icon: Icons.search, color: Colors.teal),
    CategoryHome(
        name: 'Lost/Found',
        api: 'lostfound',
        icon: Icons.help,
        color: Colors.pink),
    CategoryHome(
        name: 'Free',
        api: 'free',
        icon: Icons.volunteer_activism,
        color: Colors.cyan),
  ];

  @override
  void initState() {
    super.initState();
    // Fetch listings for the initial category (e.g., 'cars')
    _fetchListings('car'); // Ensure 'cars' is a valid category
  }

  Future<void> _fetchListings(String category) async {
    final listingProvider =
        Provider.of<ListingProvider>(context, listen: false);

    // Check if the category is valid before fetching
    if (category.isEmpty || !listingProvider.listings.containsKey(category)) {
      // Handle invalid category (e.g., show a message or default to 'cars')
      print("Invalid category: $category. Defaulting to 'cars'.");
      category = 'car'; // Fallback to a default category
    }

    await listingProvider.fetchListings(category);
  }

  @override
  Widget build(BuildContext context) {
    final listingProvider = Provider.of<ListingProvider>(context);
    final products = listingProvider.listings[selectedCategory] ?? [];

    return Scaffold(
      body: Column(
        children: [
          // 🔹 Search and Filter Section
          SearchAndFilterPage(
            categories: _categories,
            onFilterChanged: (filters) {
              setState(() {
                selectedCategory = filters.isNotEmpty ? filters.first.api : '';
              });
              _fetchListings(
                  selectedCategory); // Fetch new listings based on category
            },
            onSearchQueryChanged: (query) {
              // Handle search query changes here if necessary.
            },
          ),

          // 🔹 Product Grid Section
          Expanded(
            child: listingProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : (products.isEmpty
                    ? const Center(
                        child: Text('No product  found.',
                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600 ? 3 : 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];

                          // Dynamically create the item based on selected category
                          BaseListing item = PropertyBuilder.createProperty(
                            selectedCategory,
                            product
                                .toJson(), // Convert the product to Map<String, dynamic>
                          );

                          return PropertyCard(
                            selectedCategory: selectedCategory,
                            item: item,
                          );
                        })),
          ),
        ],
      ),

      // 🔹 Bottom Navigation
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/addproperty');
              break;
            case 2:
              context.go('/notifications');
              break;
            case 3:
              context.go('/profile');
              break;
          }
        },
      ),
    );
  }
}

class PropertyBuilder {
  static BaseListing createProperty(
      String selectedCategory, Map<String, dynamic> productData) {
    if (selectedCategory == "car") {
      return Car.fromJson(productData); // Expecting Map<String, dynamic>
    } else if (selectedCategory == "house") {
      return House.fromJson(productData); // Expecting Map<String, dynamic>
    } else {
      throw Exception("Invalid category");
    }
  }
}
