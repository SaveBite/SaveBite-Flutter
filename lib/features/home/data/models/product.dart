class Product {
  final String date;
  final String name;
  final String category;
  final double price;
  final int quantity;
  final int reorderLevel;
  final int reorderQuantity;
  final int unitsSold;
  final double salesValue;

  Product({
    required this.date,
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    required this.reorderLevel,
    required this.reorderQuantity,
    required this.unitsSold,
    required this.salesValue,
  });
}
