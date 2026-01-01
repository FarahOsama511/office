// class OrderModel {
//   final int id;
//   final String itemName;
//   final String userName;
//   final String room;
//   final int? numberOfSugarSpoons;
//   final String? orderNotes;
//   final String? voiceUrl;
//   final String? status;
//   final String? imageUrl;

//   OrderModel({
//     required this.id,
//     required this.itemName,
//     required this.userName,
//     required this.room,
//     this.numberOfSugarSpoons,
//     required this.status,
//     required this.imageUrl,
//     this.orderNotes,
//     this.voiceUrl,
//   });

//   factory OrderModel.fromJson(Map<String, dynamic> json) {
//     return OrderModel(
//       imageUrl: json["image_url"],
//       status: json['status'],
//       id: json['id'] ?? 0,
//       itemName: json['item_name'] ?? '',
//       userName: json['user_name'] ?? '',
//       room: json['room'] ?? '',
//       numberOfSugarSpoons: json['number_of_sugar_spoons'],
//       orderNotes: json['order_notes'],
//       voiceUrl: json['voice_url'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'image_url': imageUrl,
//       'status': status,
//       'id': id,
//       'item_name': itemName,
//       'user_name': userName,
//       'room': room,
//       'number_of_sugar_spoons': numberOfSugarSpoons,
//       'order_notes': orderNotes,
//       'voice_url': voiceUrl,
//     };
//   }
// }
