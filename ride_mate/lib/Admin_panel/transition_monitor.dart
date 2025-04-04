import 'package:flutter/material.dart';

class TransitionMonitorScreen extends StatefulWidget {
  const TransitionMonitorScreen({super.key});

  @override
  State<TransitionMonitorScreen> createState() =>
      _TransitionMonitorScreenState();
}

class _TransitionMonitorScreenState extends State<TransitionMonitorScreen> {
  final List<Map<String, dynamic>> transactions = [
    {
      'id': '1234',
      'date': '2024-01-20',
      'amount': 150.00,
      'type': 'Credit',
      'status': 'Completed',
      'user': 'John Doe'
    },
    {
      'id': '1235',
      'date': '2024-01-19',
      'amount': 75.50,
      'type': 'Debit',
      'status': 'Pending',
      'user': 'Jane Smith'
    },
    // Add more sample transactions as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Monitor'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard(
                        'Total Transactions', '${transactions.length}'),
                    _buildStatCard('Total Amount', '\$225.50'),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: transaction['type'] == 'Credit'
                          ? Colors.green
                          : Colors.red,
                      child: Icon(
                        transaction['type'] == 'Credit'
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: Colors.white,
                      ),
                    ),
                    title: Text('Transaction #${transaction['id']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transaction['user']),
                        Text(transaction['date']),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${transaction['amount']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          transaction['status'],
                          style: TextStyle(
                            color: transaction['status'] == 'Completed'
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
