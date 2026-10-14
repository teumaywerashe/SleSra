// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:silesra/Dataprovider/Models.dart';
import 'package:silesra/widgets/PropertyDetailPage.dart';

class PropertyCard extends StatelessWidget {
  final BaseListing item;
  final String selectedCategory;

  const PropertyCard({
    super.key,
    required this.item,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // Navigate to the detail page and pass the item
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailPage(item: item),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: SizedBox(
          width: screenWidth * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  'assets/images/image.png',
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            _getTitle(item),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.04,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 10),
                        if (item is Car)
                          Expanded(
                            child: Text(
                              _getSubtitle(item),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.04,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        if (item is House)
                          SizedBox(height: 5), // House type-specific margin
                      ],
                    ),
                    const SizedBox(height: 5),
                    _getDetails(item, screenWidth),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTitle(BaseListing item) {
    if (item is Car) return item.carMake.name ?? 'Unknown Car';
    if (item is House) return item.houseType ?? 'Unknown House';
    return 'Unknown';
  }

  String _getSubtitle(BaseListing item) {
    if (item is Car) return item.carType.name ?? 'N/A';
    if (item is House) return item.area ?? 'N/A';
    return 'N/A';
  }

  Widget _getDetails(BaseListing item, double screenWidth) {
    if (item is Car) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('For: ${item.sellOrRent}', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Text('Price:  ${item.price}', style: TextStyle(color: Colors.green)),
        ],
      );
    }
    if (item is House) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('For: ${item.sellOrRent}', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 4),
          Text('Price:  ${item.price}', style: TextStyle(color: Colors.green)),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
