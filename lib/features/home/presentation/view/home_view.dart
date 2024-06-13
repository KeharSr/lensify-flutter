// import 'package:final_assignment/features/home/presentation/view/bottom_view/explore_view.dart';
// import 'package:final_assignment/features/home/presentation/view/bottom_view/profile_view.dart';
// import 'package:final_assignment/features/home/presentation/view/bottom_view/wishlist_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class HomeView extends ConsumerStatefulWidget {
//   const HomeView({super.key});

//   @override
//   ConsumerState <HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends ConsumerState<HomeView> {
//   int _selectedIndex = 0;

//   List<Widget> lstScreen=[
//     HomeView(),
//     ExploreView(),
//     WishlistView(),
//     ProfileView(),
//   ];
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: const Center(),
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 4.0,
//         child: SizedBox(
//           height: 60.0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   MaterialButton(
//                     minWidth: 40,
//                     onPressed: () => _onItemTapped(0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.home,
//                           color:
//                               _selectedIndex == 0 ? Colors.blue : Colors.grey,
//                         ),
//                         Text(
//                           'Home',
//                           style: TextStyle(
//                             color:
//                                 _selectedIndex == 0 ? Colors.blue : Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   MaterialButton(
//                     minWidth: 40,
//                     onPressed: () => _onItemTapped(1),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.explore_outlined,
//                           color:
//                               _selectedIndex == 1 ? Colors.blue : Colors.grey,
//                         ),
//                         Text(
//                           'Explore',
//                           style: TextStyle(
//                             color:
//                                 _selectedIndex == 1 ? Colors.blue : Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   MaterialButton(
//                     minWidth: 40,
//                     onPressed: () => _onItemTapped(2),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.favorite,
//                           color:
//                               _selectedIndex == 2 ? Colors.blue : Colors.grey,
//                         ),
//                         Text(
//                           'Wish List',
//                           style: TextStyle(
//                             color:
//                                 _selectedIndex == 2 ? Colors.blue : Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   MaterialButton(
//                     minWidth: 40,
//                     onPressed: () => _onItemTapped(3),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.person,
//                           color:
//                               _selectedIndex == 3 ? Colors.blue : Colors.grey,
//                         ),
//                         Text(
//                           'Profile',
//                           style: TextStyle(
//                             color:
//                                 _selectedIndex == 3 ? Colors.blue : Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       currentIndex: _selectedIndex,
//       onTap: (index){
//         setState(() {
//           _selectedIndex = index;
//         });
//       },
//       floatingActionButton: FloatingActionButton(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(25)),
//         ),
//         onPressed: () {},
//         backgroundColor: Colors.lightGreen,
//         child: const Icon(Icons.add_box),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }

import 'package:final_assignment/features/home/presentation/view/bottom_view/explore_view.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_view/profile_view.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_view/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int selectedIndex = 0;
  List<Widget> lstScreen = [
    const ExploreView(),
    const HomeView(),
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
