// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:office_office/features/Home/data/models/orders_model.dart';
// import '../../../../core/theming/color_manager.dart';
// import '../../../../core/theming/text_style_manager.dart';
// import '../../business logic/cubit/cubit/my_orders_cubit.dart';
// import '../../business logic/cubit/my_orders_state.dart';
// import 'details_item_widget.dart';

// Widget buildMyOrdersBlocWidget() {
//   return BlocBuilder<GetMyOrdersCubit, MyOrdersState>(
//     builder: (context, state) {
//       if (state is MyOrdersLoading) {
//         return Center(
//           child: CircularProgressIndicator(color: ColorManager.primaryColor),
//         );
//       } else if (state is MyOrdersSuccess) {
//         return DetailsItemWidget(
//           allOrders: context.read<GetMyOrdersCubit>().completedOrder,
//         );
//       } else if (state is MyOrdersError) {
//         return Center(
//           child: Text(
//             "حدث خطأ أثناء تحميل الطلبات ⚠️",
//             style: TextStyleManager.font20RegularGrey,
//           ),
//         );
//       } else {
//         return SizedBox.shrink();
//       }
//     },
//   );
// }
