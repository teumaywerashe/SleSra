import 'package:flutter/material.dart';
import 'package:silesra/Dataprovider/Models.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertyDetailPage extends StatefulWidget {
  final BaseListing item;

  const PropertyDetailPage({super.key, required this.item});

  @override
  _PropertyDetailPageState createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  // Dummy images (Replace with actual URLs if available)
  final List<String> dummyImages = [
    'https://th.bing.com/th/id/OIP.O9nIGE4tMlRXgNs7GmFFLgHaE8?rs=1&pid=ImgDetMain',
    'https://th.bing.com/th/id/R.11f731bbd2873f053162c34fa8290fd5?rik=icVk0AJMp9oQzA&riu=http%3a%2f%2fmessagenote.com%2fwp-content%2fuploads%2f2011%2f04%2ftruscany-villa.jpg&ehk=8iTNr8kqps7FTKvrlSCs3v6i0TnlT538id7qzYuWQl0%3d&risl=&pid=ImgRaw&r=0'
  ];

  void _callAdvertiser(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      debugPrint('Could not launch $phoneUri');
    }
  }

  void _messageAdvertiser(String phoneNumber) async {
    final Uri smsUri = Uri(scheme: 'sms', path: phoneNumber);
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      debugPrint('Could not launch $smsUri');
    }
  }

  void _showNoPhoneNumberDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("No Phone Number Available"),
        content:
            const Text("The advertiser has not provided a contact number."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle(widget.item)),
        backgroundColor: const Color(0xFF3F72AF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Carousel
              if (dummyImages.isNotEmpty)
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: dummyImages.length,
                    onPageChanged: (int index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.network(
                          dummyImages[index],
                          width: 350,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.broken_image,
                                size: 100, color: Colors.grey);
                          },
                        ),
                      );
                    },
                  ),
                ),

              const SizedBox(height: 16),

              // Page Indicator
              if (dummyImages.length > 1)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    '${_currentPage + 1} / ${dummyImages.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              const SizedBox(height: 16),
              Text(
                _getTitle(widget.item),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.06,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Divider(thickness: 1),
              Text(
                'Category: ${_getSubtitle(widget.item)}',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(thickness: 1),
              _getDetails(widget.item, screenWidth),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (item is Car) ...[
          Text('For: ${item.sellOrRent}', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Text('Price: ${item.price}',
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Year: ${item.yearOfMake}',
              style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Text('Mileage: ${item.mileage} km',
              style: TextStyle(color: Colors.grey)),
        ],
        if (item is House) ...[
          Text('For: ${item.sellOrRent}', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Text('Price: ${item.price}',
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Area: ${item.area} sqft', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Text('Location: ${item.phoneNumber}',
              style: TextStyle(color: Colors.grey)),
        ],
        const SizedBox(height: 16),
        // Call and Message buttons
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed:
                    (item.phoneNumber != null && item.phoneNumber!.isNotEmpty)
                        ? () => _callAdvertiser('1234')
                        : () => _showNoPhoneNumberDialog(context),
                icon: const Icon(Icons.call),
                label: const Text('Call Advertiser'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed:
                    (item.phoneNumber != null && item.phoneNumber!.isNotEmpty)
                        ? () => _messageAdvertiser(item.phoneNumber!)
                        : () => _showNoPhoneNumberDialog(context),
                icon: const Icon(Icons.message),
                label: const Text('Message Advertiser'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
