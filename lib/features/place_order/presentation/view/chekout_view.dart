import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Order Review',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductItem(
                'Nike Track suit red',
                'Nike',
                'https://via.placeholder.com/60', // Dummy Image URL
              ),
              SizedBox(height: 16),
              _buildProductItem(
                'Green Nike sports shoe',
                'Nike',
                'https://via.placeholder.com/60', // Dummy Image URL
                size: 'EU 32',
                color: 'Green',
              ),
              SizedBox(height: 16),
              _buildOrderSummary(),
              SizedBox(height: 16),
              _buildPaymentMethod(),
              SizedBox(height: 16),
              _buildShippingAddress(context),
              SizedBox(height: 20),
              _buildCheckoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductItem(String title, String brand, String imageUrl,
      {String? size, String? color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(imageUrl, height: 60, width: 60, fit: BoxFit.cover),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                brand,
                style: TextStyle(fontSize: 14, color: Colors.blue),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (size != null && color != null)
                Text(
                  'Size $size  Color $color',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
            ],
          ),
        ),
        Text(
          '\$500.0', // Dummy Price
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow('Subtotal', '\$1464.0'),
          _buildSummaryRow('Shipping Fee', '\$5.00'),
          Divider(),
          _buildSummaryRow('Order Total', '\$1615.4', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/khalti.png',
                // Path to the Khalti logo in your assets
                height: 24, // Adjust the height according to your needs
              ),
              SizedBox(width: 8),
              Text(
                'Khalti',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Change',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingAddress(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tamnoor Sikander',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.phone, size: 16, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                '+923178059528',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            'Street 35, Islamabad, Federal 48000, Pakistan',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              _showAddressBottomSheet(context);
            },
            child: Text(
              'Change',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          'Checkout \$1615.4',
          style: TextStyle(fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  void _showAddressBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      isScrollControlled: true, // Allow the bottom sheet to use more space
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAddressItem(
                      'Tamnoor Sikander',
                      '+923178059528',
                      'Street 35, Islamabad, Federal 48000, Pakistan',
                    ),
                    SizedBox(height: 16),
                    _buildAddressItem(
                      'Maria Garcia',
                      '(+541) 234 5678',
                      '789 Oak Road, Buenos Aires, Buenos Aires 1001, Argentina',
                    ),
                    SizedBox(height: 16),
                    _buildAddressItem(
                      'Liam Johnson',
                      '+447890123456',
                      '10 Park Lane, London, England SW1A 1AA, United Kingdom',
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        // Handle adding a new address
                      },
                      child: Text('Add new address'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Widget _buildAddressItem(String name, String phone, String address) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.grey.shade200,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          phone,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 4),
        Text(
          address,
          style: TextStyle(fontSize: 14),
        ),
      ],
    ),
  );
}
