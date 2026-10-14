import 'package:flutter/material.dart';
import 'package:silesra/models/product_model.dart';
import 'package:silesra/pages/HomePage.dart';

class SearchAndFilterPage extends StatefulWidget {
  final List<CategoryHome> categories;
  final Function(List<CategoryHome>) onFilterChanged;
  final Function(String) onSearchQueryChanged;

  const SearchAndFilterPage({
    super.key,
    required this.categories,
    required this.onFilterChanged,
    required this.onSearchQueryChanged,
  });

  @override
  State<SearchAndFilterPage> createState() => _SearchAndFilterPageState();
}

class _SearchAndFilterPageState extends State<SearchAndFilterPage> {
  bool _isSearching = false;
  String _searchQuery = '';
  List<CategoryHome> selectedCategories = [];
  String selectedMainCategory = '';
  String selectedSubCategory = '';

  final Map<String, List<String>> filterOptions = {
    'Houses': ['For Sale', 'For Rent'],
    'Cars': ['For Sale', 'For Rent'],
    'Others': ['Electronics', 'Clothings', 'Furnitures', 'Beauty-Health'],
    'Jobs': ['HR', 'Accounting', 'Engineering'],
    'Services': ['Cleaning', 'Plumbing', 'Electrician'],
  };

  List<CategoryHome> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    filteredCategories = widget.categories;
  }

  void _filterCategories() {
    setState(() {
      filteredCategories = widget.categories
          .where((category) =>
              category.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    });
  }

// clear search
  void _clearSearch() {
    setState(() {
      _searchQuery = '';
      filteredCategories = widget.categories;
    });
    widget.onSearchQueryChanged('');
  }

// Filter Dialog
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(
                selectedMainCategory.isEmpty
                    ? 'Select Category'
                    : 'Select Subcategory',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              // Filtered catagoreies list
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (selectedMainCategory.isEmpty)
                      ...filteredCategories.map((category) {
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedMainCategory = category.name;
                              selectedSubCategory = ''; // Reset subcategory
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3F72AF),
                          ),
                          child: Row(
                            children: [
                              Icon(category.icon, color: category.color),
                              const SizedBox(width: 8),
                              Text(
                                category.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      })
                    else
                      ...filterOptions[selectedMainCategory]!
                          .map((subCategory) {
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedSubCategory = subCategory;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedSubCategory == subCategory
                                ? const Color(0xFF3F72AF)
                                : Colors.grey,
                          ),
                          child: Text(
                            subCategory,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }),
                  ],
                ),
              ),
              actions: [
                if (selectedMainCategory.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedMainCategory = '';
                        selectedSubCategory = '';
                      });
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Color(0xFF3F72AF)),
                    ),
                  ),
                TextButton(
                  onPressed: () {
                    if (selectedMainCategory.isNotEmpty &&
                        selectedSubCategory.isNotEmpty) {
                      Navigator.of(context).pop();
                      setState(() {
                        selectedCategories = [
                          CategoryHome(
                              name: selectedMainCategory,
                              api: 'api',
                              icon: Icons.category,
                              color: Colors.blue),
                          CategoryHome(
                              name: selectedSubCategory,
                              api: 'api',
                              icon: Icons.category,
                              color: Colors.green)
                        ];
                      });
                      widget.onFilterChanged(List.from(selectedCategories));
                    } else if (selectedMainCategory.isNotEmpty) {
                      Navigator.of(context).pop();
                      setState(() {
                        selectedCategories = [
                          CategoryHome(
                              name: selectedMainCategory,
                              icon: Icons.category,
                              api: 'api',
                              color: Colors.blue)
                        ];
                      });
                      widget.onFilterChanged(List.from(selectedCategories));
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    'Apply',
                    style: TextStyle(color: Color(0xFF3F72AF)),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: const Color.fromARGB(255, 6, 64, 131),
          title: _isSearching
              ? TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                    _filterCategories();
                    widget.onSearchQueryChanged(query);
                  },
                )
              : const Text(
                  'Search & Filter',
                  style: TextStyle(color: Colors.white),
                ),
          actions: [
            _isSearching
                ? IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: _clearSearch,
                  )
                : IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _isSearching = true;
                      });
                    },
                  ),
            IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.white),
              onPressed: _showFilterDialog,
            ),
          ],
        ),
        Container(
          color: const Color(0xFFDBE2EF),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget.categories.map((category) {
                final isSelected = selectedCategories.any((selectedCategory) =>
                    selectedCategory.name == category.name);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedCategories.removeWhere((selectedCategory) =>
                            selectedCategory.name == category.name);
                      } else {
                        selectedCategories.add(category);
                      }
                    });
                    widget.onFilterChanged(List.from(selectedCategories));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? category.color : Colors.white,
                      border: Border.all(
                        color: isSelected ? category.color : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      // Catagory Horizontal menu
                      children: [
                        Icon(category.icon,
                            color: isSelected ? Colors.white : category.color),
                        const SizedBox(width: 8),
                        Text(
                          category.name,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        if (selectedCategories.isNotEmpty || selectedMainCategory.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedCategories.clear();
                  selectedMainCategory = '';
                  selectedSubCategory = '';
                });
                widget.onFilterChanged([]);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Filters cleared'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3F72AF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Clear Filters',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
