import 'dart:ui';

import '../style/app_color.dart';

class MissionTimeLeft {
  final String timeLeft;
  final Color backgroundColor;
  final Color textColor;

  MissionTimeLeft({
    required this.timeLeft,
    required this.backgroundColor,
    required this.textColor,
  });
}

class MissionTimeLeftProvider {
  static List<MissionTimeLeft> get missionTimeLeft => [
        MissionTimeLeft(
          timeLeft: "Còn 7 ngày",
          backgroundColor: AppColors.bgDetailBlue,
          textColor: AppColors.textDetailBlue,
        ),
        MissionTimeLeft(
          timeLeft: "Ngày hôm nay",
          backgroundColor: AppColors.orangeBackground,
          textColor: AppColors.bgDetailOrange,
        ),
        MissionTimeLeft(
          timeLeft: "Ngày hôm qua",
          backgroundColor: AppColors.bgDetail,
          textColor: AppColors.textDetail,
        ),
      ];
}
