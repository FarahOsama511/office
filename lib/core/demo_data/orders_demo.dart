import '../../features/Home/data/models/orders_model.dart';
import '../../features/Home/data/models/item_model.dart';
import '../../features/login/data/models/user_model.dart';

class OrdersDemoData {
  static final List<OrdersModel> _orders = [];
  static void _initializeOrders() {
    if (_orders.isEmpty) {
      _orders.addAll(_getInitialOrders());
    }
  }

  static List<OrdersModel> _getInitialOrders() {
    final now = DateTime.now();

    return [
      _createOrder(
        id: "1",
        itemId: "1",
        itemName: "قهوة تركية",
        numberOfSugarSpoons: 2,
        status: "completed",
        userId: "1",
        userName: "أحمد محمد",
        createdAt: now.subtract(Duration(days: 2)),
        orderNotes: "مع حليب إضافي",
      ),
      _createOrder(
        id: "2",
        itemId: "2",
        itemName: "قهوة أمريكية",
        numberOfSugarSpoons: 1,
        status: "onprogress",
        userId: "1",
        userName: "أحمد محمد",
        createdAt: now.subtract(Duration(hours: 1)),
        orderNotes: "بدون سكر إضافي",
      ),
    ];
  }

  static OrdersModel _createOrder({
    required String id,
    required String itemId,
    required String itemName,
    required int numberOfSugarSpoons,
    required String status,
    required String userId,
    required String userName,
    required DateTime createdAt,
    String? orderNotes,
  }) {
    return OrdersModel(
      id: id,
      numberOfSugarSpoons: numberOfSugarSpoons,
      itemId: itemId.toString(),
      status: status,
      userId: userId,
      createdAt: createdAt,
      updatedAt: createdAt,
      orderNotes: orderNotes,
      voiceUrl: null,
      item: ItemModel(
        id: itemId,
        name: itemName,
        availability: "available",
        image: _getItemImage(itemId),
      ),
      user: UserModel(
        id: userId,
        name: userName,
        email: "${userName.replaceAll(' ', '').toLowerCase()}@example.com",
        ordersLimit: 5,
        role: "employee",
        roomId: "101",
        userName: userName == "أحمد محمد" ? "ahmed" : "sara",
        fcmToken: "",
        createdAt: createdAt.toIso8601String(),
        updatedAt: createdAt.toIso8601String(),
        room: null,
        orders: [],
      ),
    );
  }

  // Get all orders (for barista)
  static List<OrdersModel> getAllOrders() {
    _initializeOrders();
    return List.from(_orders);
  }

  static List<OrdersModel> getMyOrders() {
    _initializeOrders();
    return _orders.where((order) => order.userId == "1").toList();
  }

  // Add new order
  static OrdersModel addOrder({
    required int numberOfSugarSpoons,
    required String room,
    required String notes,
    required String itemId,
    required String orderId,
  }) {
    _initializeOrders();

    final newOrder = OrdersModel(
      id: (_orders.length + 1).toString(),
      numberOfSugarSpoons: numberOfSugarSpoons,
      itemId: itemId.toString(),
      status: "waiting",
      userId: "1",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      orderNotes: notes.isEmpty ? null : notes,
      voiceUrl: null,
      item: ItemModel(
        id: itemId,
        name: _getItemName(itemId),
        availability: "available",
        image: _getItemImage(itemId),
      ),
      user: UserModel(
        id: "1",
        name: "أحمد محمد",
        userName: "ahmed",
        email: "ahmed@example.com",
        ordersLimit: 5,
        role: "employee",
        roomId: "101",
        fcmToken: "",
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        room: null,
        orders: [],
      ),
    );

    _orders.add(newOrder);
    return newOrder;
  }

  static OrdersModel editOrder({
    required String orderId,
    required int numberOfSugarSpoons,
    required String room,
    required String notes,
    required String itemId,
  }) {
    _initializeOrders();

    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index == -1) {
      throw Exception("Order not found with id: $orderId");
    }

    final oldOrder = _orders[index];

    final updatedOrder = OrdersModel(
      id: orderId,
      numberOfSugarSpoons: numberOfSugarSpoons,
      itemId: itemId,
      status: oldOrder.status,
      userId: oldOrder.userId,
      createdAt: oldOrder.createdAt,
      updatedAt: DateTime.now(),
      orderNotes: notes.isEmpty ? null : notes,
      voiceUrl: oldOrder.voiceUrl,
      item: ItemModel(
        id: itemId,
        name: _getItemName(itemId),
        availability: "available",
        image: _getItemImage(itemId),
      ),
      user: oldOrder.user,
    );

    _orders[index] = updatedOrder;
    return updatedOrder;
  }

  static void deleteOrder(String orderId) {
    _initializeOrders();
    _orders.removeWhere((order) => order.id == orderId);
  }

  static OrdersModel updateOrderStatus(String orderId, String status) {
    _initializeOrders();

    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index == -1) {
      throw Exception("Order not found with id: $orderId");
    }

    final oldOrder = _orders[index];

    final updatedOrder = OrdersModel(
      id: oldOrder.id,
      numberOfSugarSpoons: oldOrder.numberOfSugarSpoons,
      itemId: oldOrder.itemId,
      status: status,
      userId: oldOrder.userId,
      createdAt: oldOrder.createdAt,
      updatedAt: DateTime.now(),
      orderNotes: oldOrder.orderNotes,
      voiceUrl: oldOrder.voiceUrl,
      item: oldOrder.item,
      user: oldOrder.user,
    );

    _orders[index] = updatedOrder;
    return updatedOrder;
  }

  static String _getItemName(String itemId) {
    const items = {
      "1": "قهوة تركية",
      "2": "قهوة أمريكية",
      "3": "كابتشينو",
      "4": "لاتيه",
      "5": "اسبريسو",
      "7": "شاي بالنعناع",
      "8": "قهوة باردة",
    };
    return items[itemId] ?? "مشروب";
  }

  static String _getItemImage(String itemId) {
    const images = {
      "1": "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500",
      "2": "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?w=500",
      "3": "https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=500",
      "4": "https://images.unsplash.com/photo-1561882468-9110e03e0f78?w=500",
      "5": "https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=500",
      "7": "https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=500",
      "8": "https://images.unsplash.com/photo-1517487881594-2787fef5ebf7?w=500",
    };
    return images[itemId] ?? "https://via.placeholder.com/500";
  }
}
