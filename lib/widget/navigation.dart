import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../constant/btn_selected.dart';
import '../style/app_style.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar(
      {super.key, this.appBar, required this.child, this.floatingActionButton});
  final AppBar? appBar;
  final Widget child;
  final Widget? floatingActionButton;

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  void _onItemTapped(int index) {
    selectedBottomNavbarIndex = index;
    // setState(() {
    //
    // });
  }

  List _navItems = [
    {
      'icon_none': 'assets/images/home/feed/icon_bottom_nav_home_none.svg',
      'icon': 'assets/images/home/feed/icon_bottom_nav_home.svg',
      'label': 'Trang chủ',
    },
    {
      'icon_none': 'assets/images/home/feed/icon_bottom_nav_fill_none.svg',
      'icon': 'assets/images/home/feed/icon_bottom_nav_fill.svg',
      'label': 'Công việc',
    },
    // Placeholder for the FAB (center item)
    {
      'icon_none': '',
      'icon': '',
      'label': '', // Placeholder for FAB
    },
    {
      'icon_none': 'assets/images/home/feed/icon_bottom_nav_newpaper.svg',
      'icon': 'assets/images/home/feed/icon_bottom_nav_newpaper1.svg',
      'label': 'Bảng tin',
    },
    {
      'icon_none': 'assets/images/home/feed/icon_bottom_nav_search_none.svg',
      'icon': 'assets/images/home/feed/icon_bottom_nav_search.svg',
      'label': 'Tra cứu luật',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // Ngăn bàn phím đẩy FAB lên
      appBar: widget.appBar,
      body: Stack(
        children: [
          widget.child,
          _buildFloatingActionButtonCall(screenHeight),
        ],
      ),
      // floatingActionButton: widget.floatingActionButton,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildFloatingActionButton(screenHeight),
          SizedBox(
            height: screenHeight * 0.006,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: screenHeight * 0.07,
        padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.006),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(11)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Color(0x1E007DC0).withOpacity(0.1),
              offset: Offset(0, 0),
              spreadRadius: (0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int i = 0; i < _navItems.length; i++)
              i != 2
                  ? Expanded(
                      // Sử dụng Expanded để chia đều không gian
                      child: Container(
                        height: 88,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _onItemTapped(i);
                              goToPage(i);
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                selectedBottomNavbarIndex == i
                                    ? _navItems[i]['icon']
                                    : _navItems[i]['icon_none'],
                                //width: 24,
                                height: screenHeight * 0.025,
                              ),
                              SizedBox(height: screenHeight * 0.006),
                              Text(
                                _navItems[i]['label'],
                                style: selectedBottomNavbarIndex == i
                                    ? sS12W5(Color(0xff007DC0), screenWidth)
                                    : sS12W4(Color(0xffAFAFAF), screenWidth),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      width: screenHeight *
                          0.085), // Giữ khoảng cách cho vị trí FAB
          ],
        ),
      ),
    );
  }

  _buildAnimatedContainer(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 4,
      width: selectedBottomNavbarIndex == index ? 32 : 0,
      decoration: const BoxDecoration(
        color: Color(0xff007DC0),
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
    );
  }

  goToPage(int index) {
    // switch (index) {
    //   case 0:
    //     GoRouter.of(context).go('/home'); // Chuyển đến trang nhà
    //     break;
    //   case 1:
    //     GoRouter.of(context).go('/missions'); // Chuyển đến bảng tin
    //     break;
    //   case 2:
    //     break; // Placeholder cho FAB
    //   case 3:
    //     GoRouter.of(context).go('/feed'); // Chuyển đến trang tra cứu luật
    //     break;
    //   case 4:
    //     GoRouter.of(context).go('/laws');
    //     break;
    // }
  }

  _buildFloatingActionButton(double height) {
    return GestureDetector(
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          selectedBottomNavbarIndex = 2;
          GoRouter.of(context).go('/scan');
        },
        child: Container(
          padding: EdgeInsets.all(height * 0.006),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 20,
                  color: Color(0x1E007DC0).withOpacity(0.1),
                  offset: Offset(0, -25),
                  spreadRadius: (-20)),
            ],
          ),
          child: Container(
            height: height * 0.07,
            width: height * 0.07,
            padding: EdgeInsets.all(height * 0.0165),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xff93D9FF),
                  Color(0xff007DC0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SvgPicture.asset(
              'assets/images/home/feed/icon_bottom_nav_scan.svg',
              // width: 32,
              // height: 32,
            ),
          ),
        ),
      ),
    );
  }

  _buildFloatingActionButtonCall(double height) {
    return Positioned(
      right: height * 0.025,
      bottom: height * 0.1,
      child: Container(
        height: height * 0.05,
        width: height * 0.05,
        padding: EdgeInsets.all(height * 0.012),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffFFB862),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Color(0xff55595D).withOpacity(0.6),
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: SvgPicture.asset('assets/images/home/feed/icon_float_menu.svg'),
      ),
    );
  }
}
