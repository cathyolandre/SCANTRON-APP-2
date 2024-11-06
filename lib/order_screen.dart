import 'package:flutter/material.dart';
import 'models/order_counter.dart'; // Import the public OrderCounter class
import 'receipt_screen.dart'; // Import the receipt screen
import 'package:provider/provider.dart'; // Add provider import
import 'models/stock_provider.dart'; // Add the StockProvider import

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  final OrderCounter _orderCounter = OrderCounter();
  final double pricePerItem = 5.0;

  @override
  Widget build(BuildContext context) {
    double totalPrice = _orderCounter.orderCount * pricePerItem;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SCANTRON ORDER',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Order Quantity:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '${_orderCounter.orderCount}',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _orderCounter.decrement();
                    });
                  },
                  icon: Icon(Icons.remove, color: Colors.black),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _orderCounter.increment();
                    });
                  },
                  icon: Icon(Icons.add, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Total Price: ₱${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  letterSpacing: 1,
                ),
              ),
            ),
            SizedBox(height: 1),
            ElevatedButton(
              onPressed: () {
                int currentStock = Provider.of<StockProvider>(context, listen: false).stock;

                if (_orderCounter.orderCount <= currentStock) {
                  Provider.of<StockProvider>(context, listen: false)
                      .restock(currentStock - _orderCounter.orderCount);

                  // Save the transaction in StockProvider
                  Provider.of<StockProvider>(context, listen: false).addTransaction(
                    _orderCounter.orderCount,
                    totalPrice,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReceiptScreen(
                        orderQuantity: _orderCounter.orderCount,
                        totalPrice: totalPrice,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Not enough stock available')),
                  );
                }
              },
              child: Text(
                "Place Order",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
