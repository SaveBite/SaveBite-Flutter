import 'package:flutter/material.dart';
import 'package:save_bite/features/Tracking/Presentation/pages/add_edit_product.dart';
import 'package:save_bite/features/Tracking/domain/entities/tracking_product_request_entity.dart';

typedef ProductActionCallback = void Function(bool isEdit);

class TrackingViewBody extends StatelessWidget {
  final ProductActionCallback onProductAction;

  TrackingViewBody({super.key, required this.onProductAction});

  // Placeholder list of products for editing (replace with real data source)
  final List<TrackingProduct> _sampleProducts = [
    TrackingProduct(
      id: 1,
      name: 'Sample Product 1',
      numberId: '002',
      category: 'Category A',
      label: 'Label A',
      quantity: 10,
      startDate: '2025-07-01',
      endDate: '2025-12-01',
      imageUrl:  '/data/user/0/com.example.save_bite/cache/4ac80497-5950-4ea9-813f-7da801eb5cdf/img_00013.jpg',
    ),
  ];

  void _showProductActionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Product'),
              onTap: () {
                Navigator.pop(context); // Close the dialog
                onProductAction(false); // Notify parent of add action
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditProductPage(
                      onPageOpened: (isEdit) => onProductAction(isEdit),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Product'),
              onTap: () {
                Navigator.pop(context); // Close the dialog
                if (_sampleProducts.isNotEmpty) {
                  onProductAction(true); // Notify parent of edit action
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditProductPage(
                        initialProduct: _sampleProducts[0], // Set to null to avoid pre-filling
                        productId: _sampleProducts[0].id,
                        onPageOpened: (isEdit) => onProductAction(isEdit),
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('No products available to edit.')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Tracking View',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _showProductActionDialog(context),
            child: Text('Manage Product'),
          ),
        ],
      ),
    );
  }
}