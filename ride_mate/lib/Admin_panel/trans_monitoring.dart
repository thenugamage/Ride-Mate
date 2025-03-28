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

  String selectedStatus = "All";
  String selectedSort = "Transaction ID";
  String searchQuery = "";

  List<Map<String, String>> get filteredTransactions {
    return transactions.where((transaction) {
      bool matchesSearchQuery =
          transaction["transactionId"]!.toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          transaction["bookingId"]!.toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          transaction["amount"]!.toLowerCase().contains(
            searchQuery.toLowerCase(),
          );

      bool matchesStatus =
          selectedStatus == "All" || transaction["status"] == selectedStatus;

      return matchesSearchQuery && matchesStatus;
    }).toList();
  }

  void _sortTransactions() {
    setState(() {
      if (selectedSort == "Amount") {
        transactions.sort(
          (a, b) =>
              double.parse(a["amount"]!).compareTo(double.parse(b["amount"]!)),
        );
      } else if (selectedSort == "Transaction ID") {
        transactions.sort(
          (a, b) => a["transactionId"]!.compareTo(b["transactionId"]!),
        );
      }
    });
  }

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

  void _viewTransaction(int index) {
    var txn = filteredTransactions[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Transaction Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Transaction ID: ${txn["transactionId"]}'),
              Text('Booking ID: ${txn["bookingId"]}'),
              Text('Amount: \$${txn["amount"]}'),
              Text('Status: ${txn["status"]}'),
              Text('Date: ${txn["date"]}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
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
      body: Stack(
        children: [
          // 🌈 Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color.fromARGB(255, 205, 174, 0)],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // 🧢 Custom AppBar with Gradient
                AppBar(
                  title: Text(
                    'Transaction Monitoring',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.black),
                      onPressed: _addTransaction,
                      tooltip: 'Add New Transaction',
                    ),
                  ],
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Color.fromARGB(255, 205, 174, 0),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // 🔍 Search
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

                      // 🔽 Filters
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
                            items:
                                ['All', 'Completed', 'Pending', 'Failed']
                                    .map(
                                      (String value) =>
                                          DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          ),
                                    )
                                    .toList(),
                          ),
                          DropdownButton<String>(
                            value: selectedSort,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedSort = newValue!;
                                _sortTransactions();
                              });
                            },
                            items:
                                ['Transaction ID', 'Amount']
                                    .map(
                                      (String value) =>
                                          DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          ),
                                    )
                                    .toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 📋 Transaction List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      var txn = filteredTransactions[index];
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
                            txn["transactionId"]!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "Booking ID: ${txn["bookingId"]}\nAmount: \$${txn["amount"]}\nStatus: ${txn["status"]}",
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
        ],
      ),
    );
  }
}
