import 'package:flutter/material.dart';

class HistoryOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'History Order',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: 10, // Example count
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.receipt_long, color: Colors.white),
              ),
              title: Text('Order #${1000 + index}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Photobook Premium A4'),
                  Text(
                      'Tanggal: ${DateTime.now().subtract(Duration(days: index)).toString().substring(0, 10)}'),
                  Text('Total: Rp. 150.000',
                      style: TextStyle(color: Colors.red)),
                ],
              ),
              trailing: Chip(
                label: Text('Selesai'),
                backgroundColor: Colors.green[100],
                labelStyle: TextStyle(color: Colors.green),
              ),
            ),
          );
        },
      ),
    );
  }
}
