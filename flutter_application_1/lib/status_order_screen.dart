import 'package:flutter/material.dart';

class StatusOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Status Order',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: 5, // Example count
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Icon(Icons.local_shipping, color: Colors.white),
              ),
              title: Text('Order #${2000 + index}'),
              subtitle: Text('In Progress'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStatusStep('Order Diterima', true),
                      _buildStatusStep('Sedang Diproses', true),
                      _buildStatusStep('Dalam Pengiriman', index < 2),
                      _buildStatusStep('Selesai', false),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusStep(String title, bool isCompleted) {
    return Row(
      children: [
        Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCompleted ? Colors.green : Colors.grey,
        ),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: isCompleted ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }
}
