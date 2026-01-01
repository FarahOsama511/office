import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../generated/l10n.dart';
import '../../business logic/cubit/cubit/item_cubit.dart';
import '../../business logic/cubit/cubit/my_orders_cubit.dart';
import '../screens/home_screen.dart';
import '../screens/order_history_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/status_order_screen.dart';

class BottomNavigation extends StatefulWidget {
  _BottomNavigationState createState() => _BottomNavigationState();
  const BottomNavigation({super.key});
}

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  @override
  void initState() {
    BlocProvider.of<ItemCubit>(context).getAllItems();
    BlocProvider.of<GetMyOrdersCubit>(context).getAllOrders();
    super.initState();
  }

  int currentindex = 0;
  List<Widget> pages = [
    HomeScreen(),
    StatusOrderScreen(),
    OrderHistoryScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 600),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(animation),

            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(-.2, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: pages[currentindex],
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: ColorManager.orangeColor,
        unselectedItemColor: ColorManager.greyColor,
        selectedFontSize: 15.sp,
        unselectedFontSize: 15.sp,
        currentIndex: currentindex,
        onTap: (value) {
          setState(() {
            currentindex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            label: S.of(context).homeScreen,
            activeIcon: AnimatedContainer(
              curve: Curves.linear,
              duration: Duration(milliseconds: 200),
              width: 50.w,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.home, size: 30),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment, size: 30),
            label: S.of(context).orders,
            activeIcon: AnimatedContainer(
              curve: Curves.linear,
              duration: Duration(milliseconds: 200),
              width: 50.w,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.assignment, size: 30),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, size: 30),
            label: S.of(context).history,
            activeIcon: AnimatedContainer(
              curve: Curves.linear,
              duration: Duration(milliseconds: 200),
              width: 50.w,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.history, size: 30),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: S.of(context).profile,
            activeIcon: AnimatedContainer(
              curve: Curves.linear,
              duration: Duration(milliseconds: 200),
              width: 50.w,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.person, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
