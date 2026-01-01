import 'room_model.dart';

class UserModel {
  final String? id;
  final String? roomId;
  final String? name;
  final String? userName;
  final String? email;
  final int? ordersLimit;
  final String? role;
  final String? fcmToken;
  final String? createdAt;
  final String? updatedAt;
  final RoomModel? room;
  final List<dynamic>? orders;

  UserModel({
    required this.id,
    required this.roomId,
    required this.name,
    required this.userName,
    required this.email,
    required this.ordersLimit,
    required this.role,
    required this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
    required this.room,
    required this.orders,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      roomId: json["room_id"],
      name: json["name"],
      userName: json["userName"],
      email: json["email"],
      ordersLimit: json["orders_limit"],
      role: json["role"],
      fcmToken: json["fcm_token"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      room: json["room"] != null ? RoomModel.fromJson(json["room"]) : null,
      orders: json["orders"] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "room_id": roomId,
      "name": name,
      "userName": userName,
      "email": email,
      "orders_limit": ordersLimit,
      "role": role,
      "fcm_token": fcmToken,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "room": room?.toJson(),
      "orders": orders,
    };
  }
}
