import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../data/mission.dart';
import '../logics/check_type.dart';
import '../model/mission.dart';
import '../style/app_color.dart';
import '../style/app_style.dart';
import '../widget/mission_button.dart';
import '../widget/mission_card_info.dart';
import '../widget/navigation.dart';
import '../widget/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This keeps track of the selected filter
  String timeFilter = 'Hôm nay';
  String typeFilter = 'Tất cả';
  List<Mission> listMission = getMissionList();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BottomNavbar(
      appBar: _buildAppBar(),
      child: Column(
        children: [
          SearchFeed(
            hintText: 'Tìm kiếm...',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MissionButton(),
                  _buildListWork(),
                  _buildTitleOnFeed(
                    onFilterSelect: (filter) {
                      setState(() {
                        timeFilter = filter;
                      });
                    },
                    countPost: '6',
                    title: 'Công việc của bạn',
                    width: screenWidth,
                    height: screenHeight,
                    showFilter: true,
                    selectedFilter: timeFilter,
                  ),
                  _buildFilter(),
                  _buildPostMonthList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      elevation: 0,
      title: Row(
        children: [
          ClipRect(
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xff55595D),
              child: Image.asset(
                'assets/images/home/feed/logo_avatar.png',
                width: 28,
                height: 28,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10), // Adds spacing between avatar and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Xin chào buổi sáng,',
                  style: styleS14W4(Color(0xff55595D)),
                ),
                Text(
                  'Nguyễn Tấn Khoa',
                  style: styleS20W5(Color(0xff55595D)),
                ),
              ],
            ),
          ),
          SvgPicture.asset('assets/images/home/feed/icon_notification.svg'),
        ],
      ),
    );
  }

  _buildListWork() {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).go('/home/all-missions');
      },
      child: Container(
        margin: EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(11),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Màu sắc bóng
                spreadRadius: 2, // Độ lan tỏa của bóng
                blurRadius: 5, // Độ mờ của bóng
                offset: Offset(0, 2), // Vị trí bóng (x, y)
              ),
            ]),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.28),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.greenTop,
                              AppColors.greenBot
                            ], // Thay đổi màu tại đây
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/logo/mission/work_calendar.svg',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Danh sách công việc',
                              style: styleS14W5(AppColors.bgOryza),
                            ),
                            Text(
                              'Tính từ ngày 01 tháng 10, 2024',
                              style: styleS12W4(AppColors.divider),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    'assets/icons/logo/mission/top_right_arrow.svg',
                    height: 24,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 8, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '45',
                          style: styleS18W5(AppColors.bgOryza),
                        ),
                        Text(
                          '/50 nhiệm vụ',
                          style: styleS12W5(AppColors.divider),
                        ),
                      ],
                    ),
                    Text(
                      '80%',
                      style: styleS14W5(AppColors.bgOryza),
                    )
                  ],
                ),
              ),
              Container(
                height: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(6),
                    value: 0.8,
                    backgroundColor: AppColors.blueProcess,
                    color: AppColors.blueLeft,
                    //valueColor: AlwaysStoppedAnimation<Color>(AppColors.blueLeft),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTitleOnFeed({
    String? countPost,
    required String title,
    Function()? onTap,
    Function(String)? onFilterSelect,
    bool showFilter = false,
    String? selectedFilter,
    required double height,
    required double width,
  }) {
    List<String> filters = ['Hôm nay', 'Trong tuần', 'Trong tháng'];

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16, top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (countPost != null)
                Container(
                  height: 18,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Color(0xff007DC0),
                    borderRadius: BorderRadius.circular(44),
                  ),
                  child: Text(
                    countPost,
                    style: sS12W4(Colors.white, width),
                  ),
                ),
              if (countPost != null) SizedBox(width: 4),
              Text(
                title,
                style: sS16W5(Color(0xff55595D), width),
              ),
              Spacer(),
              if (onTap != null)
                GestureDetector(
                  onTap: onTap,
                  child: Row(
                    children: [
                      Text('Xem hết', style: styleS14W4(Color(0xff007DC0))),
                      SizedBox(width: 6),
                      SvgPicture.asset(
                        'assets/images/home/feed/icon_right_arrow.svg',
                        height: 20,
                      ),
                    ],
                  ),
                ),
              if (showFilter)
                PopupMenuButton<String>(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Bo góc cho khung dropdown
                  ),
                  onSelected: (String value) {
                    if (onFilterSelect != null) {
                      onFilterSelect(value);
                      setState(() {
                        selectedFilter = value; // Cập nhật giá trị đã chọn
                      });
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return filters
                        .where((filter) => filter != selectedFilter)
                        .map<PopupMenuItem<String>>((String value) {
                      return PopupMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: sS14W4(Color(0xff808080), width),
                        ),
                      );
                    }).toList();
                  },
                  child: Container(
                    //height: width * 0.067,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffCCCCCC)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/logo/mission/calendar.svg', // Icon bạn muốn hiển thị trong ô chọn
                              width: 16,
                              height: 16,
                            ),
                            SizedBox(width: 8), // Khoảng cách bên trái
                            Text(
                              selectedFilter ??
                                  'Hôm nay', // Hiển thị thông điệp
                              style: sS14W5(Color(0xff808080), width),
                            ),
                          ],
                        ),
                        SizedBox(width: 8),
                        SvgPicture.asset(
                          'assets/icons/logo/arrow-down.svg',
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  _buildPostMonthList() {
    // Lọc danh sách nhiệm vụ theo typeFilter
    List<Mission> filteredMissions = listMission.where((mission) {
      if (typeFilter == 'Tất cả') {
        return true; // Hiển thị tất cả nhiệm vụ
      }
      return mission.type == typeFilter; // Kiểm tra loại nhiệm vụ
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView.builder(
        physics:
            NeverScrollableScrollPhysics(), // Disable scrolling for the inner list
        shrinkWrap: true, // Ensure it takes only the space it needs
        itemCount: filteredMissions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: MissionCardAndInfo(
              isChecked: false,
              post: filteredMissions[index],
              onSelect: (p0) {},
              missionType: MissionTypeProvider.missionTypes[0],
            ),
          );
        },
      ),
    );
  }

  _buildFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFilterItem('Tất cả'),
          _buildFilterItem('Tuần tra'),
          _buildFilterItem('Kế hoạch'),
          _buildFilterItem('Nhiệm vụ'),
        ],
      ),
    );
  }

  _buildFilterItem(String s) {
    bool isSelected = typeFilter == s;
    return GestureDetector(
      onTap: () {
        setState(() {
          typeFilter = s; // Update the selected filter
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff007DC0) : Color(0xffFE3E5E5),
          borderRadius: BorderRadius.circular(44),
        ),
        child: Text(
          s,
          style: styleS14W5(isSelected ? Colors.white : Color(0xff55595D)),
        ),
      ),
    );
  }

  _buildFloatingActionButton() {
    return Positioned(
      right: 16,
      bottom: 16,
      child: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(44),
        ),
        splashColor: Color(0xff007DC0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffFFB862),
          ),
          child:
              SvgPicture.asset('assets/images/home/feed/icon_float_menu.svg'),
        ),
        backgroundColor: Color(0xff007DC0),
      ),
    );
  }
}
