// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:silesra/models/product_model.dart';
// import 'package:silesra/widgets/PropertyCard.dart';
// import 'package:silesra/widgets/custom_bottom_navigation.dart';
// import 'search_and_filter_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;

//   final List<Category> _categories = [
//     Category(name: 'Houses',api:'house', icon: Icons.home, color: Colors.blue ),
//     Category(name: 'Cars',api:'car' ,icon: Icons.directions_car, color: Colors.red),
//     Category(name: 'Others',api:'house' , icon: Icons.category, color: Colors.purple),
//     Category(name: 'Jobs',api:'house' , icon: Icons.work, color: Colors.orange),
//     Category(name: 'Sponsored',api:'house' , icon: Icons.star, color: Colors.yellow),
//     Category(
//         name: 'Services',api:'house' , icon: Icons.design_services, color: Colors.green),
//     Category(name: 'Wanted',api:'wanted' , icon: Icons.search, color: Colors.teal),
//     Category(name: 'Lost/Found',api:'lostfound' , icon: Icons.help, color: Colors.pink),
//     Category(name: 'Free',api:'free' , icon: Icons.volunteer_activism, color: Colors.cyan),
//   ];

//   List<Category> selectedCategories = [];
//   String searchQuery = '';
//   List<Product> products = [];
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchProducts(); // Fetch initial data
//   }

//   Future<void> _fetchProducts({String? category}) async {
//     print(" %%%%%%% Selected catagory is ======> $category");
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       List<Product> fetchedProducts = [];
//       if (category == null || category.isEmpty) {
//         //fetchedProducts = await ApiService.fetchAllProducts();
//         print('Fetch car is called since catagory null or isEmpty');
//         fetchedProducts = await ApiService.fetchcars();
//       } else {
//         print('Fetch car is called since catagory null or isEmpty-> $category');
//         fetchedProducts = await ApiService.fetchProductsByCategory(category,
//             categoryName: category);
//         //fetchedProducts = await ApiService.fetchcars();
//       }

//       setState(() {
//         products = fetchedProducts;
//         isLoading = false;
//       });
//     } catch (error) {
//       setState(() {
//         isLoading = false;
//       });
//       print('Error fetching products: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Apply search query to filter products
//     final filteredProducts = products;

//     return Scaffold(
//       body: Column(
//         children: [
//           // Search and Filter Section
//           SearchAndFilterPage(
//             categories: _categories,
//             onFilterChanged: (filters) {
//               final selectedCategory =
//                   filters.isNotEmpty ? filters.first.api : null; // load what filters will contain here api,name,icons
//               setState(() {
//                 selectedCategories = filters;
//               });
//               _fetchProducts(category: selectedCategory); // this will send catagory cars,houses,....
//             },
//             onSearchQueryChanged: (query) {
//               setState(() {
//                 searchQuery = query;
//               });
//             },
//           ),

//           // Product Grid Section
//           Expanded(
//             child: isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : filteredProducts.isEmpty
//                     ? const Center(
//                         child: Text(
//                           'No products found.',
//                           style: TextStyle(fontSize: 18, color: Colors.grey),
//                         ),
//                       )
//                     : GridView.builder(
//                         padding: const EdgeInsets.all(16.0),
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount:
//                               MediaQuery.of(context).size.width > 600 ? 3 : 2,
//                           crossAxisSpacing: 16.0,
//                           mainAxisSpacing: 16.0,
//                           childAspectRatio: 0.8,
//                         ),
//                         itemCount: filteredProducts.length,
//                         itemBuilder: (context, index) {
//                           final product = filteredProducts[
//                               index]; // single product for detail
//                           return GestureDetector(
//                             onTap: () {
//                               context.go('/detail', extra: product);
//                             },
//                             child: PropertyCard(product: product),
//                           );
//                         },
//                       ),
//           ),
//         ],
//       ),

//       // Bottom Navigation
//       bottomNavigationBar: CustomBottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//           switch (index) {
//             case 0:
//               context.go('/home');
//               break;
//             case 1:
//               context.go('/addproperty');
//               break;
//             case 2:
//               context.go('/notifications');
//               break;
//             case 3:
//               context.go('/profile');
//               break;
//           }
//         },
//       ),
//     );
//   }
// }
