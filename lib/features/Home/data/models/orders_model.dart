import 'dart:convert';
import '../../../login/data/models/user_model.dart';
import 'item_model.dart';

class OrdersModel {
  final String? id;
  final int? numberOfSugarSpoons;
  final String? itemId;
  final String? status;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ItemModel? item;
  final UserModel? user;
  final String? orderNotes;
  final String? voiceUrl;

  OrdersModel({
    this.voiceUrl,
    this.id,
    this.numberOfSugarSpoons,
    this.itemId,
    this.status,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.item,
    this.user,
    this.orderNotes,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      id: json["id"],
      numberOfSugarSpoons: json["number_of_sugar_spoons"],
      itemId: json["item_id"].toString(),
      status: json["status"],
      userId: json["user_id"].toString(),
      voiceUrl: json["voice_url"],
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"]).toLocal()
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.parse(json["updated_at"]).toLocal()
          : null,
      orderNotes: json["order_notes"],
      item: json["item"] != null
          ? (json["item"] is String
                ? ItemModel.fromJson(jsonDecode(json["item"]))
                : ItemModel.fromJson(json["item"]))
          : null,

      user: json["user"] != null
          ? (json["user"] is String
                ? UserModel.fromJson(jsonDecode(json["user"]))
                : UserModel.fromJson(json["user"]))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "voice_url": voiceUrl,
      "id": id,
      "number_of_sugar_spoons": numberOfSugarSpoons,
      "item_id": itemId,
      "status": status,
      "user_id": userId,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
      "order_notes": orderNotes,
      "item": item != null ? jsonEncode(item!.toJson()) : null,
      "user": user != null ? jsonEncode(user!.toJson()) : null,
    };
  }

  OrdersModel copyWith({
    String? id,
    String? status,
    String? voiceUrl,
    ItemModel? item,
  }) {
    return OrdersModel(
      id: id ?? this.id,
      status: status ?? this.status,
      voiceUrl: voiceUrl ?? this.voiceUrl,
      item: item ?? this.item,
    );
  }

  @override
  String toString() {
    return 'OrdersModel(id: $id, "voice:"${voiceUrl}, status: $status, item: ${item},itemid:${itemId}  spoons: $numberOfSugarSpoons),createdAt: ${createdAt})';
  }
}
