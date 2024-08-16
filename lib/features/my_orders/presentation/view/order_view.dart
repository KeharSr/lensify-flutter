import 'package:final_assignment/features/my_orders/presentation/view_model/view_orders_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Assume the ViewOrdersViewModel and other necessary code are already defined

class MyOrdersView extends ConsumerStatefulWidget {
  const MyOrdersView({super.key});

  @override
  _MyOrdersViewState createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends ConsumerState<MyOrdersView> {
  @override
  void initState() {
    super.initState();
    // Fetch orders when the widget is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(viewOrdersViewModelProvider.notifier).getOrderByUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewState = ref.watch(viewOrdersViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: viewState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : viewState.orders.isEmpty
              ? const Center(
                  child: Text(
                    "No orders found",
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: viewState.orders.length,
                  itemBuilder: (context, index) {
                    final order = viewState.orders[index];
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: const DecorationImage(
                                  image: NetworkImage(''),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Order Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.status,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Text(
                                  //   'Order Date: ${order.}',
                                  //   style:
                                  //       const TextStyle(color: Colors.black54),
                                  // ),
                                  const SizedBox(height: 4),
                                  // Text(
                                  //   'Shipping Date: ${order.shippingDate}',
                                  //   style:
                                  //       const TextStyle(color: Colors.black54),
                                  // ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Order ID: ${order.id}',
                                    style:
                                        const TextStyle(color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            // Arrow Icon
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black54,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
