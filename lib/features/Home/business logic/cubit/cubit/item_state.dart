import '../../../data/models/item_model.dart';

abstract class ItemState {}

final class ItemInitial extends ItemState {}

final class ItemLoading extends ItemState {}

final class ItemSuccess extends ItemState {
  List<ItemModel> items;
  ItemSuccess(this.items);
}

final class ItemError extends ItemState {
  final String error;
  ItemError(this.error);
}
