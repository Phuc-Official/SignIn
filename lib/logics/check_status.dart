import 'dart:ui';

import '../style/app_color.dart';

class MissionStatus {
  final String status;
  final Color textColor;

  MissionStatus({
    required this.status,
    required this.textColor,
  });
}

class MissionStatusProvider {
  static List<MissionStatus> get missionStatuses => [
        MissionStatus(
          status: "Chưa thực hiện",
          textColor: AppColors.notDone,
        ),
        MissionStatus(
          status: "Đang thực hiện",
          textColor: AppColors.inProgress,
        ),
        MissionStatus(
          status: "Chờ phê duyệt",
          textColor: AppColors.await,
        ),
        MissionStatus(
          status: "Hoàn thành",
          textColor: AppColors.misionBlue,
        ),
        MissionStatus(
          status: "Huỷ",
          textColor: AppColors.cancel,
        ),
        MissionStatus(
          status: "Quá hạn",
          textColor: AppColors.outDate,
        ),
      ];
}
