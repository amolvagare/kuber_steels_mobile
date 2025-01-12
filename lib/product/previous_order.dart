import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../components/header.dart';
import 'product_page.dart';

class PreviousOrderPage extends StatelessWidget {
  const PreviousOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Your Previous Orders',
        showBackButton: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor:
                  WidgetStateProperty.all(AppColors.primaryColor),
                  columnSpacing: 20,
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Sl. No',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Order ID',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Date',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Total Amt',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Attachment',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Delivered',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    10, // Example number of rows
                        (index) => DataRow(
                      cells: [
                        DataCell(Text('${index + 1}')),
                        DataCell(Text('ORD${1000 + index}')),
                        DataCell(Text('2024-11-0${index + 1}')),
                        DataCell(Text('\$${(index + 1) * 100}')),
                        const DataCell(Icon(Icons.attachment)),
                        const DataCell(Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to the previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 5),
                      Text(
                        'Back to Menu',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductPage()),
                    ); // Navigate to place a new order
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'Order Again',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.add_shopping_cart),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
