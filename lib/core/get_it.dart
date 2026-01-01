import 'package:get_it/get_it.dart';
import '../features/Home/business logic/cubit/cubit/add_myorder_cubit.dart';
import '../features/Home/business logic/cubit/cubit/delete_my_order_cubit.dart';
import '../features/Home/business logic/cubit/cubit/edit_myorder_cubit.dart';
import '../features/Home/business logic/cubit/cubit/item_cubit.dart';
import '../features/Home/business logic/cubit/cubit/log_out_cubit.dart';
import '../features/Home/business logic/cubit/cubit/my_orders_cubit.dart';
import '../features/Home/data/repositiries/get_my_orders_repo.dart';
import '../features/Home/data/repositiries/item_repo.dart';
import '../features/Home/data/repositiries/log_out_repo.dart';
import '../features/Home/data/repositiries/my_order_repo.dart';
import '../features/barista_home/business_logic/get_all_orders_cubit.dart';
import '../features/barista_home/business_logic/update_status_order_cubit.dart';
import '../features/barista_home/data/repositiries/get_all_orders_repo.dart';
import '../features/login/bussines logic/login/login_cubit.dart';
import '../features/login/data/repositries/login_repo.dart';

final setUp = GetIt.instance;

Future<void> init() async {
  // Cubits
  setUp.registerFactory(() => LoginCubit(setUp()));
  setUp.registerFactory(() => AddMyOrderCubit(setUp()));
  setUp.registerFactory(() => GetMyOrdersCubit(setUp()));
  setUp.registerFactory(() => ItemCubit(setUp()));
  setUp.registerFactory(() => GetAllOrdersCubit(setUp()));
  setUp.registerFactory(() => LogOutCubit(setUp()));
  setUp.registerFactory(() => UpdateOrderCubit(setUp()));
  setUp.registerFactory(() => DeleteOrderCubit(setUp()));
  setUp.registerFactory(() => EditMyOrderCubit(setUp()));
  // Repositories
  setUp.registerLazySingleton(() => LoginRepo());
  setUp.registerLazySingleton(() => ItemRepo());
  setUp.registerLazySingleton(() => GetMyOrdersRepo());
  setUp.registerLazySingleton(() => MyOrderRepo());
  setUp.registerLazySingleton(() => GetAllOrdersRepo());
  setUp.registerLazySingleton(() => LogOutRepo());
}
