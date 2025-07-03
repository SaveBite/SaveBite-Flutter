class TrackingProductEntity {
  final int id;
  final String name;
  final String numberId;
  final String category;
  final int quantity;
  final String label;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String? image;

  const TrackingProductEntity({
    required this.id,
    required this.name,
    required this.numberId,
    required this.category,
    required this.quantity,
    required this.label,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.image,
  });
}
