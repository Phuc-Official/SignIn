import 'package:flutter/material.dart';

import '../style/app_style.dart';
import 'check_status.dart';
import 'check_time_left.dart';
import 'check_type.dart';

class MissionStyleProvider {
  static Color getBackgroundColorForTimeLeft(String timeLeft) {
    final missionTimeLeft = MissionTimeLeftProvider.missionTimeLeft.firstWhere(
      (s) => s.timeLeft == timeLeft,
      orElse: () => MissionTimeLeft(
        timeLeft: timeLeft,
        backgroundColor: Colors.black, // Màu mặc định
        textColor: Colors.white, // Màu mặc định
      ),
    );
    return missionTimeLeft.backgroundColor;
  }

  static TextStyle getTextStyleForTimeLeft(String timeLeft) {
    final missionTimeLeft = MissionTimeLeftProvider.missionTimeLeft.firstWhere(
      (s) => s.timeLeft == timeLeft,
      orElse: () => MissionTimeLeft(
        timeLeft: timeLeft,
        backgroundColor: Colors.black, // Màu mặc định
        textColor: Colors.white, // Màu mặc định
      ),
    );
    return styleS12W4(missionTimeLeft.textColor);
  }

  static TextStyle getTextStyleForStatus(String status,
      {TextStyle? customStyle}) {
    final missionStatus = MissionStatusProvider.missionStatuses.firstWhere(
      (s) => s.status == status,
      orElse: () => MissionStatus(
        status: status, // Giá trị mặc định nếu không tìm thấy
        textColor: Colors.white, // Màu mặc định
      ),
    );
    final baseStyle = styleS12W4(missionStatus.textColor);

    // Kết hợp với customStyle
    return customStyle != null ? baseStyle.merge(customStyle) : baseStyle;
  }

  static TextStyle getTextStyleForType(String type, {TextStyle? customStyle}) {
    final missionTypes = MissionTypeProvider.missionTypes.firstWhere(
      (s) => s.type == type,
      orElse: () => MissionType(
        type: type,
        textColor: Colors.white,
        backgroundColor: Colors.black,
      ),
    );

    // Lấy kiểu chữ cơ bản
    final baseStyle = styleS12W5(missionTypes.textColor);

    // Kết hợp với customStyle
    return customStyle != null ? baseStyle.merge(customStyle) : baseStyle;
  }

  static Color getBackgroundColorForType(String type) {
    final missionTypes = MissionTypeProvider.missionTypes.firstWhere(
      (s) => s.type == type,
      orElse: () => MissionType(
        type: type, // Giá trị mặc định nếu không tìm thấy
        textColor: Colors.white, // Màu mặc định
        backgroundColor: Colors.black,
      ),
    );
    return missionTypes.backgroundColor; // Lấy màu nền
  }
}
