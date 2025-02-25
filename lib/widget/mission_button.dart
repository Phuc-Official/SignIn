import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../style/app_color.dart';
import '../style/app_style.dart';

class MissionButton extends StatelessWidget {
  final Color buttonColor; // Thêm tham số màu nền

  const MissionButton({
    Key? key,
    this.buttonColor = AppColors.taskButton, // Giá trị mặc định
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.054)
          .copyWith(top: 24),
      child: Column(children: [
        Row(children: [
          Expanded(
            child: _buildButton(
              'assets/icons/logo/groupbtn/task.svg',
              'Công việc được giao',
              '+12 trong tuần này',
              '32',
              () {
                //GoRouter.of(context).go('/missions/all-missions');
              },
              context,
              AppColors.taskButton,
            ),
          ),
          SizedBox(width: screenWidth * 0.054),
          Expanded(
            child: _buildButton(
              'assets/icons/logo/groupbtn/done.svg',
              'Công việc hoàn thành',
              '+12 trong tuần này',
              '20',
              () {
                Navigator.push(context, {} as Route<Object?>);
              },
              context,
              AppColors.lightBlue,
            ),
          ),
        ]),
      ]),
    );
  }

  Widget _buildButton(
    String iconPath,
    String label,
    String addTask,
    String taskCount,
    VoidCallback onPressed,
    BuildContext context,
    Color backgroundColor, // Nhận màu nền
  ) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        // padding: EdgeInsets.all(screenWidth * 0.027),
        padding: EdgeInsets.all(screenWidth * 0.0022 * 12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                iconPath,
                height: 44,
              ),
              Container(
                height: 44,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SvgPicture.asset(
                    //   'assets/icons/logo/mission/top_right_arrow.svg',
                    //   height: 20,
                    // ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.0265),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: sS14W5(AppColors.divider, screenWidth),
                  ),
                  Text(
                    addTask,
                    style: sS10W4(AppColors.taskCount, screenWidth),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 32,
                    child: Text(
                      taskCount,
                      style: sS24W7(AppColors.bgOryza, screenWidth),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
