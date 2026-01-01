import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:office_office/features/Home/data/models/item_model.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../generated/l10n.dart';
import '../../../login/presentation/widgets/build_widget_text_field.dart';
import '../../business logic/cubit/cubit/item_cubit.dart';
import '../../business logic/cubit/cubit/item_state.dart';
import '../widgets/categories_widget.dart';
import '../widgets/items_widget.dart' show ItemsWidget;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchKeyword = "";
  void searchFunction(String keyWord) {
    setState(() {
      searchKeyword = keyWord.toLowerCase();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTextByTime(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  SizedBox(
                    height: 30.h,
                    width: 30.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.asset(
                        "assets/images/logo-removebg-preview.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                S.of(context).titleHomeScreen,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 10.h),
              BuildWidgetTextField(
                prefixIcon: Icon(
                  Icons.search,
                  size: 30,
                  color: ColorManager.greyColor,
                ),
                hintText: S.of(context).search,
                controller: _searchController,
                onChanged: searchFunction,
              ),
              SizedBox(height: 10.h),
              CategoriesWidget(),
              // SizedBox(height: 10.h),
              Divider(color: Theme.of(context).colorScheme.outline),
              BlocBuilder<ItemCubit, ItemState>(
                builder: (context, state) {
                  if (state is ItemLoading) {
                    return Expanded(
                      child: Skeletonizer(
                        child: ItemsWidget(
                          items: List.generate(
                            6,
                            (_) => ItemModel(
                              id: "1",
                              name: "orange juice",
                              availability: "availability",
                              image:
                                  "https://images.unsplash.com/photo-1485808191679-5f86510681a2?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (state is ItemSuccess) {
                    final filteredItems = state.items
                        .where(
                          (item) => item.name!.toLowerCase().contains(
                            searchKeyword.trim(),
                          ),
                        )
                        .toList();
                    if (filteredItems.isNotEmpty) {
                      return Expanded(child: ItemsWidget(items: filteredItems));
                    } else {
                      return Expanded(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorManager.lightGrey,
                                radius: 30.r,
                                child: Icon(
                                  Icons.search,
                                  color: ColorManager.whiteColors,
                                  size: 40,
                                ),
                              ),
                              Text(
                                S.of(context).noDrinks,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  } else if (state is ItemError) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          S.of(context).ordersLoadError,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getTextByTime() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return S.of(context).goodMorning;
    } else {
      return S.of(context).goodNight;
    }
  }
}
