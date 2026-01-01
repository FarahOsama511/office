import 'package:dartz/dartz.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/demo_data/items_demo.dart';
import '../../../../core/helpers/db_helper.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../models/item_model.dart';

class ItemRepo {
  ItemRepo();
  Future<RepoResult<List<ItemModel>>> getItems() async {
    try {
      final items = ItemsDemoData.getItems();
      await LocalDatabaseHelper.insertItems(items);
      logger.d("===$items");
      return Right(items);
    } catch (e) {
      final cachedAllItems = await LocalDatabaseHelper.getItems();
      if (cachedAllItems.isNotEmpty) {
        for (var item in cachedAllItems) {
          print("Item: ${item.name}, Image: ${item.image}");
        }
        return Right(cachedAllItems);
      }
      logger.d("error is $e");
      return left(ApiErrorHandler.handle(e));
    }
  }
}
