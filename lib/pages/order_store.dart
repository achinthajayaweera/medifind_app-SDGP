class MedicineItem {
  final String name;
  final String category;
  final int quantity;

  const MedicineItem({
    required this.name,
    required this.category,
    required this.quantity,
  });
}

class OrderItem {
  final String pharmacyName;
  final String amount;
  final String orderId;
  final String deliveredAt;
  final String status;
  final List<MedicineItem> medicines;

  const OrderItem({
    required this.pharmacyName,
    required this.amount,
    required this.orderId,
    required this.deliveredAt,
    required this.status,
    this.medicines = const [],
  });
}

class OrderStore {
  static final OrderStore instance = OrderStore._();
  OrderStore._();

  final List<OrderItem> orders = [];

  void addOrder(OrderItem order) {
    orders.insert(0, order);
  }
}
