import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final List<CartItem> items = [
    CartItem(
      name: 'Green Nike sports shoe',
      brand: 'Nike',
      color: 'Green',
      size: 'EU 34',
      price: 134.0,
      quantity: 1,
    ),
    CartItem(
      name: 'Blue T-shirt for all ages',
      brand: 'Zara',
      color: 'Blue',
      size: '',
      price: 35.0,
      quantity: 1,
    ),
    CartItem(
      name: 'Track suit red',
      brand: 'Nike',
      color: 'Red',
      size: '',
      price: 500.0,
      quantity: 1,
    ),
    CartItem(
      name: 'Air Max Red & Black',
      brand: 'Nike',
      color: 'Red & Black',
      size: '',
      price: 600.0,
      quantity: 1,
    ),
    CartItem(
      name: 'Iphone 14 pro 512gb',
      brand: 'Apple',
      color: '',
      size: '',
      price: 1998.0,
      quantity: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double total =
        items.fold(0, (sum, item) => sum + (item.price * item.quantity));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Cart', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) => Divider(height: 1),
              itemBuilder: (context, index) {
                return CartItemWidget(item: items[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Text('Checkout \$${total.toStringAsFixed(1)}'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                // Implement checkout logic
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final String name;
  final String brand;
  final String color;
  final String size;
  final double price;
  final int quantity;

  CartItem({
    required this.name,
    required this.brand,
    required this.color,
    required this.size,
    required this.price,
    required this.quantity,
  });
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.shopping_bag, color: Colors.grey),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
                if (item.color.isNotEmpty || item.size.isNotEmpty)
                  Text('${item.color} ${item.size}',
                      style: TextStyle(color: Colors.grey)),
                SizedBox(height: 8),
                Text('\$${item.price}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove, size: 16),
                      onPressed: () {
                        // Implement decrease quantity
                      },
                    ),
                    Text('${item.quantity}'),
                    IconButton(
                      icon: Icon(Icons.add, size: 16),
                      onPressed: () {
                        // Implement increase quantity
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
