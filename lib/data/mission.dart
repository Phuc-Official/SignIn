// mission_data.dart
import 'package:flutter/material.dart';

import '../model/mission.dart';

List<Mission> getMissionList() {
  return [
    Mission(
      postId: '0',
      title:
          'Hệ thống kiểm soát tại thành phố Nam Tân Uyên, tỉnh Bình Dương đảm bảo an ninh và quản lý chặt chẽ các',
      username: 'Nguyễn Văn A',
      dataPublished: DateTime.now(),
      type: 'Tuần tra',
      postUrl: 'assets/images/home/feed/img_post.png',
      description:
          'Luật phòng chống tác hại của rượu, bia có hiệu lực từ ngày 01/01/2020, điều chỉnh mức nồng độ cồn vi phạm khi tham gia giao thông. Tuy nhiên, thực tế vẫn còn nhiều vướng mắc trong việc thực hiện. Bài viết này cung cấp cái nhìn tổng quan về tình trạng vi phạm nồng độ cồn khi tham gia giao thông, cùng với những số liệu thống kê từ Ủy ban an toàn giao thông Quốc gia cho thấy tỷ lệ người điều khiển phương tiện sau khi uống rượu bia rất cao. Đặc biệt vào dịp lễ, Tết, tình trạng này có xu hướng gia tăng, đòi hỏi các cơ quan chức năng cần có biện pháp xử lý nghiêm để giảm thiểu tai nạn giao thông.',
      timeLeft: 'Ngày hôm nay',
      status: 'Chưa thực hiện',
      startDate: DateTime(2023, 10, 17),
      endDate: DateTime(2024, 1, 2),
      workingTime: '07:00 SA - 11:30 SA',
      repeat: 'Thứ 2, Thứ 4, Thứ 6',
      startTime: TimeOfDay(hour: 12, minute: 00),
      endTime: TimeOfDay(hour: 15, minute: 00),
    ),
    Mission(
      postId: '1',
      title:
          'Thông báo công khai nội dung Kế hoạch Tuần tra kiểm soát trên tuyến của Đội CSGT số 3,...',
      username: 'Nguyễn Văn A',
      dataPublished: DateTime.now(),
      type: 'Kế hoạch',
      postUrl: 'assets/images/home/feed/img_post.png',
      description:
          'Kế hoạch tuần tra kiểm soát được triển khai nhằm đảm bảo an toàn giao thông và xử lý các hành vi vi phạm, đặc biệt là liên quan đến nồng độ cồn. Đội CSGT số 3 sẽ tập trung vào các tuyến đường trọng điểm và thời điểm cao điểm để kiểm tra, xử lý nghiêm các trường hợp vi phạm.',
      timeLeft: 'Còn 7 ngày',
      status: 'Đang thực hiện',
      startDate: DateTime(2023, 10, 17),
      endDate: DateTime(2024, 1, 2),
      workingTime: '07:00 SA - 11:30 SA',
      repeat: 'Thứ 2, Thứ 4, Thứ 6',
      startTime: TimeOfDay(hour: 13, minute: 00),
      endTime: TimeOfDay(hour: 15, minute: 00),
    ),
    Mission(
      postId: '2',
      title:
          'Hệ thống kiểm soát tại thành phố Nam Tân Uyên, tỉnh Bình Dương đảm bảo an ninh và quản lý chặt chẽ các...',
      username: 'Nguyễn Văn A',
      dataPublished: DateTime.now(),
      type: 'Nhiệm vụ',
      postUrl: 'assets/images/home/feed/img_post.png',
      description:
          'Luật phòng chống tác hại của rượu, bia có hiệu lực từ ngày 01/01/2020, điều chỉnh mức nồng độ cồn vi phạm khi tham gia giao thông. Tuy nhiên, thực tế vẫn còn nhiều vướng mắc trong việc thực hiện. Bài viết này cung cấp cái nhìn tổng quan về tình trạng vi phạm nồng độ cồn khi tham gia giao thông, cùng với những số liệu thống kê từ Ủy ban an toàn giao thông Quốc gia cho thấy tỷ lệ người điều khiển phương tiện sau khi uống rượu bia rất cao. Đặc biệt vào dịp lễ, Tết, tình trạng này có xu hướng gia tăng, đòi hỏi các cơ quan chức năng cần có biện pháp xử lý nghiêm để giảm thiểu tai nạn giao thông.',
      timeLeft: 'Ngày hôm nay',
      status: 'Chưa thực hiện',
      startDate: DateTime(2023, 10, 17),
      endDate: DateTime(2024, 1, 2),
      workingTime: '07:00 SA - 11:30 SA',
      repeat: 'Thứ 2, Thứ 4, Thứ 6',
      startTime: TimeOfDay(hour: 16, minute: 00),
      endTime: TimeOfDay(hour: 18, minute: 00),
    ),
    Mission(
      postId: '3',
      title:
          'Thông báo công khai nội dung Kế hoạch Tuần tra kiểm soát trên tuyến của Đội CSGT số 3,...',
      username: 'Nguyễn Văn A',
      dataPublished: DateTime.now(),
      type: 'Nhiệm vụ',
      postUrl: 'assets/images/home/feed/img_post.png',
      description:
          'Đội CSGT số 3 sẽ triển khai kế hoạch tuần tra kiểm soát trên các tuyến đường nhằm phát hiện và xử lý kịp thời các hành vi vi phạm. Mục tiêu là nâng cao ý thức chấp hành pháp luật về an toàn giao thông trong cộng đồng.',
      timeLeft: 'Ngày hôm qua',
      status: 'Chờ phê duyệt',
      startDate: DateTime(2023, 10, 17),
      endDate: DateTime(2024, 1, 2),
      workingTime: '07:00 SA - 11:30 SA',
      repeat: 'Thứ 2, Thứ 4, Thứ 6',
      startTime: TimeOfDay(hour: 18, minute: 00),
      endTime: TimeOfDay(hour: 19, minute: 00),
    ),
    Mission(
      postId: '4',
      title:
          'Thông báo công khai nội dung Kế hoạch Tuần tra kiểm soát trên tuyến của Đội CSGT số 3,...',
      username: 'Nguyễn Văn A',
      dataPublished: DateTime.now(),
      type: 'Nhiệm vụ',
      postUrl: 'assets/images/home/feed/img_post.png',
      description:
          'Đội CSGT số 3 sẽ triển khai kế hoạch tuần tra kiểm soát trên các tuyến đường nhằm phát hiện và xử lý kịp thời các hành vi vi phạm. Mục tiêu là nâng cao ý thức chấp hành pháp luật về an toàn giao thông trong cộng đồng.Thông báo triển khai kế hoạch tuần tra kiểm soát nhằm đảm bảo an toàn giao thông. Đội CSGT số 3 sẽ thực hiện các biện pháp cần thiết để phát hiện và xử lý các vi phạm liên quan đến nồng độ cồn, góp phần giảm thiểu tai nạn giao thông.',
      timeLeft: 'Ngày hôm nay',
      status: 'Hoàn thành',
      startDate: DateTime(2023, 10, 17),
      endDate: DateTime(2024, 1, 2),
      workingTime: '07:00 SA - 11:30 SA',
      repeat: 'Thứ 2, Thứ 4, Thứ 6',
      startTime: TimeOfDay(hour: 08, minute: 30),
      endTime: TimeOfDay(hour: 15, minute: 00),
    ),
    Mission(
      postId: '5',
      title:
          'Thông báo công khai nội dung Kế hoạch Tuần tra kiểm soát trên tuyến của Đội CSGT số 3,...',
      username: 'Nguyễn Văn A',
      dataPublished: DateTime.now(),
      type: 'Nhiệm vụ',
      postUrl: 'assets/images/home/feed/img_post.png',
      description:
          'Thông báo triển khai kế hoạch tuần tra kiểm soát nhằm đảm bảo an toàn giao thông. Đội CSGT số 3 sẽ thực hiện các biện pháp cần thiết để phát hiện và xử lý các vi phạm liên quan đến nồng độ cồn, góp phần giảm thiểu tai nạn giao thông.',
      timeLeft: 'Ngày hôm nay',
      status: 'Huỷ',
      startDate: DateTime(2023, 10, 17),
      endDate: DateTime(2024, 1, 2),
      workingTime: '07:00 SA - 11:30 SA',
      repeat: 'Thứ 2, Thứ 4, Thứ 6',
      startTime: TimeOfDay(hour: 07, minute: 00),
      endTime: TimeOfDay(hour: 15, minute: 00),
    ),
    Mission(
      postId: '6',
      title:
          'Thông báo công khai nội dung Kế hoạch Tuần tra kiểm soát trên tuyến của Đội CSGT số 3,...',
      username: 'Nguyễn Văn A',
      dataPublished: DateTime.now(),
      type: 'Kế hoạch',
      postUrl: 'assets/images/home/feed/img_post.png',
      description:
          'Thông báo triển khai kế hoạch tuần tra kiểm soát nhằm đảm bảo an toàn giao thông. Đội CSGT số 3 sẽ thực hiện các biện pháp cần thiết để phát hiện và xử lý các vi phạm liên quan đến nồng độ cồn, góp phần giảm thiểu tai nạn giao thông.',
      timeLeft: 'Ngày hôm nay',
      status: 'Quá hạn',
      startDate: DateTime(2023, 10, 17),
      endDate: DateTime(2024, 1, 2),
      workingTime: '07:00 SA - 11:30 SA',
      repeat: 'Thứ 2, Thứ 4, Thứ 6',
      startTime: TimeOfDay(hour: 07, minute: 00),
      endTime: TimeOfDay(hour: 15, minute: 00),
    ),
  ];
}
