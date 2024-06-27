// import 'package:final_assignment/features/home/presentation/view/bottom_view/dashboard_view.dart';
// import 'package:final_assignment/features/home/presentation/view/bottom_view/explore_view.dart';
// import 'package:final_assignment/features/home/presentation/view/bottom_view/prescriptions_view.dart';
// import 'package:final_assignment/features/home/presentation/view/bottom_view/profile_view.dart';
// import 'package:final_assignment/features/home/presentation/view/bottom_view/wishlist_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class HomeView extends ConsumerStatefulWidget {
//   const HomeView({super.key});

//   @override
//   ConsumerState<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends ConsumerState<HomeView> {
//   int selectedIndex = 0;
//   List<Widget> lstScreen = [
//     const DashboardView(),
//     const ExploreView(),
//     const PrescriptionsView(),
//     const WishlistView(),
//     const ProfileView(),
//   ];

//   void onItemTapped(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: lstScreen[selectedIndex],
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 8.0,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               _buildNavItem(Icons.home, "Home", 0),
//               _buildNavItem(Icons.explore, "Explore", 1),

//               const SizedBox(width: 48), // Space for the FAB
//               _buildNavItem(Icons.favorite, "Wishlist", 3),
//               _buildNavItem(Icons.person, "Profile", 4),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           onItemTapped(2);
//         },
//         child: const Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }

//   Widget _buildNavItem(IconData icon, String label, int index) {
//     return InkWell(
//       onTap: () => onItemTapped(index),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Icon(icon, color: selectedIndex == index ? Colors.blue : Colors.grey),
//           Text(
//             label,
//             style: TextStyle(
//               color: selectedIndex == index ? Colors.blue : Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }







import 'package:final_assignment/features/home/presentation/view/bottom_view/explore_view.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_view/home_view.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_view/profile_view.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_view/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<MainView> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  int selectedIndex = 0;
  List<Widget> lstScreen = [
    const HomeView(),
    const ExploreView(),
    const WishlistView(),
    const ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lstScreen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
