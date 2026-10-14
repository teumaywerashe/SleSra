import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  final List<Map<String, String>> transactions = [
    {
      'property': 'Luxury Villa',
      'date': '2024-11-01',
      'amount': '\$250,000',
    },
    {
      'property': 'Modern Apartment',
      'date': '2024-10-20',
      'amount': '\$1,500 (Rent)',
    },
    {
      'property': 'Office Space',
      'date': '2024-09-15',
      'amount': '\$75,000',
    },
  ];

  void _deleteTransaction(int index) {
    setState(() {
      transactions.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Transaction deleted"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F7),
      appBar: AppBar(
        title: const Text("Transaction History"),
        backgroundColor: const Color(0xFF3F72AF),
      ),
      body: transactions.isEmpty
          ? const Center(
              child: Text(
                "No transactions yet.",
                style: TextStyle(
                  color: Color(0xFF112D4E),
                  fontSize: 18,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Dismissible(
                  key: Key(transaction['property']! + index.toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    _deleteTransaction(index);
                  },
                  child: GestureDetector(
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Delete Transaction?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _deleteTransaction(index);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text("Delete"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      color: const Color(0xFFDBE2EF),
                      child: ListTile(
                        leading: const Icon(
                          Icons.receipt,
                          color: Color(0xFF112D4E),
                        ),
                        title: Text(
                          transaction['property']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF112D4E),
                          ),
                        ),
                        subtitle: Text(
                          "Date: ${transaction['date']}",
                          style: const TextStyle(color: Color(0xFF112D4E)),
                        ),
                        trailing: Text(
                          transaction['amount']!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: const Color.fromARGB(255, 19, 18, 18)),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
