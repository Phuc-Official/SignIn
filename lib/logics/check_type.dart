import 'dart:ui';

import '../style/app_color.dart';

class MissionType {
  final String type;
  final Color backgroundColor;
  final Color textColor;
  final Color? containerColor;
  final String? icon;

  MissionType({
    this.containerColor,
    required this.type,
    required this.backgroundColor,
    required this.textColor,
    this.icon,
  });
}

class MissionTypeProvider {
  static List<MissionType> get missionTypes => [
        MissionType(
          type: "Tuần tra",
          backgroundColor: AppColors.misionBlue,
          textColor: AppColors.white,
          icon: 'assets/icons/logo/mission/patrol.svg',
          containerColor: AppColors.containerBlue,
        ),
        MissionType(
          type: "Kế hoạch",
          backgroundColor: AppColors.textDetailGreen,
          textColor: AppColors.white,
          icon: 'assets/icons/logo/mission/plan.svg',
          containerColor: AppColors.containerGreen,
        ),
        MissionType(
          type: "Nhiệm vụ",
          backgroundColor: AppColors.purpleMission,
          textColor: AppColors.white,
          icon: 'assets/icons/logo/mission/mission.svg',
          containerColor: AppColors.containerPurple,
        ),
      ];
}
