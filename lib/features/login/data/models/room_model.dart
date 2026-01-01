import 'branch_model.dart';

class RoomModel {
  final String? id;
  final String? branchId;
  final String? name;
  final String? createdAt;
  final String? updatedAt;
  final BranchModel? branch;

  RoomModel({
    required this.id,
    required this.branchId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.branch,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json["id"],
      branchId: json["branch_id"],
      name: json["name"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      branch: json["branch"] != null
          ? BranchModel.fromJson(json["branch"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "branch_id": branchId,
      "name": name,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "branch": branch?.toJson(),
    };
  }
}
