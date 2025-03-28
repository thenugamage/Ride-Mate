import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transaction Monitoring',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TransactionMonitoringPage(),
    );
  }
}

class TransactionMonitoringPage extends StatefulWidget {
  @override
  _TransactionMonitoringPageState createState() =>
      _TransactionMonitoringPageState();
}

class _TransactionMonitoringPageState extends State<TransactionMonitoringPage> {
  // Sample list of transactions
  List<Map<String, String>> transactions = [
    {
      "transactionId": "TX123",
      "bookingId": "B123",
      "amount": "20.00",
      "status": "Completed",
      "date": "2023-02-01",
    },
    {
      "transactionId": "TX124",
      "bookingId": "B124",
      "amount": "25.00",
      "status": "Pending",
      "date": "2023-02-02",
    },
    {
      "transactionId": "TX125",
      "bookingId": "B125",
      "amount": "30.00",
      "status": "Failed",
      "date": "2023-02-05",
    },
    {
      "transactionId": "TX126",
      "bookingId": "B126",
      "amount": "15.00",
      "status": "Completed",
      "date": "2023-02-06",
    },
  ];

  // Selected filter options
  String selectedStatus = "All";
  String selectedSort = "Transaction ID";
  String searchQuery = "";

  // Search function to filter the transaction list
  List<Map<String, String>> get filteredTransactions {
    return transactions.where((transaction) {
      // Search filter
      bool matchesSearchQuery =
          transaction["transactionId"]!.contains(searchQuery) ||
              transaction["bookingId"]!.contains(searchQuery) ||
              transaction["amount"]!.contains(searchQuery);

      // Filter by status
      bool matchesStatus =
          selectedStatus == "All" || transaction["status"] == selectedStatus;

      return matchesSearchQuery && matchesStatus;
    }).toList();
  }

  // Sorting function
  void _sortTransactions() {
    setState(() {
      if (selectedSort == "Amount") {
        filteredTransactions.sort(
          (a, b) =>
              double.parse(a["amount"]!).compareTo(double.parse(b["amount"]!)),
        );
      } else if (selectedSort == "Transaction ID") {
        filteredTransactions.sort(
          (a, b) => a["transactionId"]!.compareTo(b["transactionId"]!),
        );
      }
    });
  }

  // Add new transaction (simulated)
  void _addTransaction() {
    setState(() {
      transactions.add({
        "transactionId": "TX${transactions.length + 126}",
        "bookingId": "B${transactions.length + 126}",
        "amount": "${(transactions.length + 126) * 10}.00",
        "status": "Completed",
        "date": "2023-02-10",
      });
    });
  }

  // Function to view transaction details (popup dialog)
  void _viewTransaction(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Transaction Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transaction ID: ${filteredTransactions[index]["transactionId"]}',
              ),
              Text('Booking ID: ${filteredTransactions[index]["bookingId"]}'),
              Text('Amount: \$${filteredTransactions[index]["amount"]}'),
              Text('Status: ${filteredTransactions[index]["status"]}'),
              Text('Date: ${filteredTransactions[index]["date"]}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction Monitoring',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow, // App bar color
        elevation: 4.0,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: _addTransaction,
            tooltip: 'Add New Transaction',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                labelText: 'Search Transactions',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
            ),

            SizedBox(height: 20),

            // Filter options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedStatus,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedStatus = newValue!;
                    });
                  },
                  items: <String>[
                    'All',
                    'Completed',
                    'Pending',
                    'Failed',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: selectedSort,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSort = newValue!;
                      _sortTransactions();
                    });
                  },
                  items: <String>[
                    'Transaction ID',
                    'Amount',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Transaction List
            Expanded(
              child: ListView.builder(
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                      leading: Icon(
                        Icons.account_balance_wallet,
                        color: Colors.yellow,
                        size: 40,
                      ),
                      title: Text(
                        filteredTransactions[index]["transactionId"]!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "Booking ID: ${filteredTransactions[index]["bookingId"]}\nAmount: \$${filteredTransactions[index]["amount"]}\nStatus: ${filteredTransactions[index]["status"]}",
                        style: TextStyle(fontSize: 14),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.visibility, color: Colors.blue),
                        onPressed: () => _viewTransaction(index),
                        tooltip: 'View Transaction',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
