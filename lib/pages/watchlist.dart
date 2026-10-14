import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  // Declare the watchlistItems as a state variable.
  List<Map<String, String>> watchlistItems = [
    {'name': 'Luxury Villa', 'type': 'Property'},
    {'name': 'Modern Apartment', 'type': 'Property'},
    {'name': 'Commercial Office Space', 'type': 'Property'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        backgroundColor: const Color(0xFF3F72AF),
      ),
      body: watchlistItems.isEmpty
          ? const Center(
              child: Text(
                "Your watchlist is empty.",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF112D4E),
                ),
              ),
            )
          : ListView.builder(
              itemCount: watchlistItems.length,
              itemBuilder: (context, index) {
                final item = watchlistItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  color: const Color(0xFFDBE2EF),
                  child: ListTile(
                    leading: const Icon(
                      Icons.home,
                      color: Color(0xFF112D4E),
                    ),
                    title: Text(
                      item['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF112D4E),
                      ),
                    ),
                    subtitle: Text(item['type']!),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _removeFromWatchlist(context, index);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _removeFromWatchlist(BuildContext context, int index) {
    // Show confirmation dialog before removing
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Item'),
          content: const Text(
              'Are you sure you want to remove this item from your watchlist?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle the removal
                setState(() {
                  watchlistItems.removeAt(index);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Item removed from your watchlist.'),
                  ),
                );
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }
}
