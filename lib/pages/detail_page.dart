import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:silesra/Dataprovider/Models.dart';
import 'package:url_launcher/url_launcher.dart'; // For making phone calls and sending messages

class DetailsPage extends StatefulWidget {
  final dynamic item; // Pass the item dynamically here (can be car or house)

  const DetailsPage({Key? key, required this.item}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  // Function to call the advertiser
  void _callAdvertiser(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      debugPrint('Could not launch $phoneUri');
    }
  }

  // Function to message the advertiser
  void _messageAdvertiser(String phoneNumber) async {
    final Uri smsUri = Uri(scheme: 'sms', path: phoneNumber);
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      debugPrint('Could not launch $smsUri');
    }
  }

  // Get title based on item type (Car or House)
  String _getTitle(dynamic item) {
    if (item is Car) {
      return item.carType.name ?? 'Car Details';
    } else if (item is House) {
      return item.houseType ?? 'House Details';
    }
    return 'Item Details';
  }

  // Get details based on item type (Car or House)
  Widget _getDetails(dynamic item) {
    if (item is Car) {
      return _buildCarDetails(item);
    } else if (item is House) {
      return _buildHouseDetails(item);
    }
    return Container(); // Return an empty container if no matching type
  }

  // Build Car details layout
  Widget _buildCarDetails(Car car) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (car.mileage != null) _buildDetailRow('Brand', car.mileage!),
            if (car.model != null) _buildDetailRow('Model', car.model!),
            if (car.category.name != null)
              _buildDetailRow('Type', car.category.name!),
          ],
        ),
      ),
    );
  }

  // Build House details layout
  Widget _buildHouseDetails(House house) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (house.area != null) _buildDetailRow('Area', '${house.area} sqft'),
            if (house.numberOfBedrooms != null)
              _buildDetailRow('Bedrooms', house.numberOfBedrooms!.toString()),
            if (house.numberOfBathrooms != null)
              _buildDetailRow('Bathrooms', house.numberOfBathrooms!.toString()),
            if (house.description != null)
              _buildDetailRow('Location', house.description!),
          ],
        ),
      ),
    );
  }

  // Helper method to build a detail row
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int pageCount = widget.item.images?.length ?? 0; // Total number of images

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle(widget.item)),
        backgroundColor: const Color(0xFF3F72AF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home'); // Navigates to the Home page
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Carousel with PageView
              if (widget.item.images != null && widget.item.images!.isNotEmpty)
                Card(
                  elevation: 4,
                  child: SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _controller,
                          itemCount: widget.item.images!.length,
                          onPageChanged: (int index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Image.network(
                              widget.item.images![index],
                              width: 350,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${_currentPage + 1} / $pageCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 16),

              // Price
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.item.price?.isNotEmpty ?? false
                        ? '\$${widget.item.price}'
                        : 'Price: Not Available',
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Description
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.item.description ?? 'No description available.',
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Contact Information
              if (widget.item.contact != null)
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Advertiser: ${widget.item.contact}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

              const SizedBox(height: 16),

              // Display details based on item type
              _getDetails(widget.item),

              const SizedBox(height: 16),

              // Call and Message Buttons
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: widget.item.contact != null
                              ? () => _callAdvertiser(widget.item.contact!)
                              : null,
                          icon: const Icon(Icons.call),
                          label: const Text('Call Advertiser'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: widget.item.contact != null
                              ? () => _messageAdvertiser(widget.item.contact!)
                              : null,
                          icon: const Icon(Icons.message),
                          label: const Text('Message Advertiser'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}