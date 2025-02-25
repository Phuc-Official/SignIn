import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/screens/report_detail.dart';

import '../data/mission.dart';
import '../logics/check_type.dart';
import '../logics/mission_type_provider.dart';
import '../model/mission.dart';
import '../style/app_color.dart';
import '../style/app_style.dart';
import '../widget/report_card.dart';

class MissionDetailPage extends StatefulWidget {
  const MissionDetailPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Mission post;

  @override
  _MissionDetailPageState createState() => _MissionDetailPageState();
}

class _MissionDetailPageState extends State<MissionDetailPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // Thêm listener cho PageController nếu cần
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose(); // Giải phóng PageController
    super.dispose();
  }

  MissionType _getMissionType(String type) {
    return MissionTypeProvider.missionTypes.firstWhere(
      (missionType) => missionType.type == type,
      orElse: () => MissionType(
        type: '',
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        icon: null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blueTop.withOpacity(0.07),
                        spreadRadius: 20,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPostContent(screenWidth, screenHeight),
                    SizedBox(height: 24),
                    _buildAssignedPerson(),
                    _buildTitleAndContent(),
                    SizedBox(height: 24),
                    _buildAttachFiles(),
                    _buildWorkReport(context),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildSelectedPosts(context),
            ],
          ),
        ],
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    List<Mission> listMission = getMissionList(); // Lấy danh sách nhiệm vụ

    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      title: Text(
        'Chi tiết công việc',
        style: styleS18W5(Color(0xff55595D)),
      ),
    );
  }

  _buildPostContent(double width, double height) {
    final missionType =
        _getMissionType(widget.post.type); // Lấy MissionType dựa trên type
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 24),
      child: Column(
        children: [
          _buildTypePost(),
          SizedBox(height: 8),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.searchBar,
                ),
                padding: EdgeInsets.all(12),
                child: missionType?.icon != null
                    ? SvgPicture.asset(
                        missionType!.icon!,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 72,
                        height: 72,
                        color: Colors.grey,
                      ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  child: Text(
                    widget.post.title,
                    softWrap: true,
                    style: sS22W6(Color(0xff222222), width).copyWith(height: 0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          _buildDateTime(),
        ],
      ),
    );
  }

  _buildDateTime() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          // Hàng đầu tiên
          Row(
            children: [
              _buildInfoContainer(widget.post.startDate, 'Ngày bắt đầu'),
              SizedBox(width: 16),
              _buildInfoContainer(
                  widget.post.endDate, 'Ngày kết thúc'), // Cập nhật ở đây
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildInfoContainer(
                  formatWorkingTime(widget.post.startTime, widget.post.endTime),
                  'Thời gian'),
              SizedBox(width: 16),
              _buildInfoContainer(widget.post.repeat, 'Lặp lại vào'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoContainer(dynamic timePost, String timeLabel) {
    String displayTimePost;
    if (timePost is DateTime) {
      displayTimePost = DateFormat('dd \'tháng\' MM, yyyy').format(timePost);
    } else if (timePost is TimeOfDay) {
      displayTimePost =
          formatTimeOfDay(timePost); // Sử dụng hàm định dạng thời gian
    } else if (timePost is String) {
      displayTimePost = timePost; // Giữ nguyên nếu đã là String
    } else {
      displayTimePost =
          'Không xác định'; // Giá trị mặc định nếu không phải kiểu hợp lệ
    }

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.searchBar,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start, // Căn trái cột
          children: [
            Text(
              timeLabel,
              style: styleS14W4(AppColors.floatingLabel),
              textAlign: TextAlign.left, // Căn trái
            ),
            Text(
              displayTimePost, // Sử dụng biến đã chuyển đổi
              style: styleS14W6(AppColors.bgOryza),
              textAlign: TextAlign.left, // Căn trái
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignedPerson() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Căn trái
        children: [
          Text('Người được phân công',
              style: styleS16W5(AppColors.floatingLabel)),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: AppColors.hintText,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Kích thước bằng nội dung
              children: [
                ClipRect(
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Color(0xff55595D),
                    child: Image.asset(
                      'assets/images/home/feed/logo_avatar.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 6),
                Text(widget.post.username, style: styleS14W4(Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildTitleAndContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/logo/mission/main_content.svg',
              ),
              SizedBox(width: 8),
              Text(
                'Mô tả công việc',
                style: styleS16W5(AppColors.black),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              //color: AppColors.searchBar,
            ),
            child: Text(
              '${widget.post.description ?? ''}', // Thay 'Ký tự phía trước: ' bằng ký tự hoặc chuỗi bạn muốn
              style: styleS14W4(Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  _buildTypePost() {
    final String postType = widget.post.type ?? '';

    final customTextStyle = styleS14W5(Colors.white);

    final textStyle = MissionStyleProvider.getTextStyleForType(
      postType,
      customStyle: customTextStyle,
    );
    final color = textStyle.color;
    final backgroundColor =
        MissionStyleProvider.getBackgroundColorForType(postType);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            postType,
            style: textStyle,
          ),
        ),
        Container(
          color: AppColors.whiteOryza,
          margin: EdgeInsets.symmetric(horizontal: 8),
          width: 1,
          height: 16,
        ),
        Text(
          'Mã công việc: ',
          style: styleS14W4(AppColors.whiteOryza),
        ),
        Text(
          widget.post.postId,
          style: styleS16W5(Colors.black),
        ),
      ],
    );
  }

  Widget _buildAttachFiles() {
    return Container(
      padding: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 24),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/logo/mission/attach_file.svg'),
                SizedBox(width: 4),
                Text(
                  'Tệp đính kèm',
                  style: styleS14W5(AppColors.bgOryza),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: AppColors.blueText,
                    borderRadius: BorderRadius.circular(44),
                  ),
                  child: Center(
                    child: Text(
                      '6',
                      style: styleS12W4(Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 240,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                _buildFileAttachmentItem(
                  icon: 'assets/images/home/feed/icon_post_office.svg',
                  title: 'Tên tập tin.docx',
                ),
                _buildFileAttachmentItem(
                  icon: 'assets/images/home/feed/icon_post_office.svg',
                  title: 'Tên tập tin.docx',
                ),
                _buildFileAttachmentItem(
                  icon: 'assets/images/home/feed/icon_post_pdf.svg',
                  title: 'Tên tập tin.pdf',
                ),
                _buildFileAttachmentItem(
                  icon: 'assets/images/home/feed/icon_post_pdf.svg',
                  title: 'Tên tập tin.pdf',
                ),
                _buildFileAttachmentItem(
                  icon: 'assets/images/home/feed/icon_post_pdf.svg',
                  title: 'Tên tập tin.pdf',
                ),
              ],
            ),
          ),
          _buildDotsIndicator(),
        ],
      ),
    );
  }

  Widget _buildDotsIndicator() {
    int itemCount = 5; // Số lượng item
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 6),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _currentIndex == index ? AppColors.hintText : AppColors.greyBtn,
          ),
        );
      }),
    );
  }

  Widget _buildFileAttachmentItem({
    required String icon,
    required String title,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16).copyWith(right: 16, left: 24),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Màu sắc bóng
            spreadRadius: 2, // Độ lan tỏa của bóng
            blurRadius: 5, // Độ mờ của bóng
            offset: Offset(0, 2), // Vị trí bóng (x, y)
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(icon, width: 24, height: 24),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    width: 1,
                    height: 16,
                    decoration: BoxDecoration(color: Color(0xFFE2E5E4)),
                  ),
                  Text(
                    title,
                    style: styleS14W4(AppColors.bgOryza),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8), // Khoảng cách giữa hàng và hình ảnh
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11), // Góc bo cho hình ảnh
              child: Container(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/home/feed/img_post.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedPosts(BuildContext context) {
    final customTextStyle =
        styleS14W5(MissionStyleProvider.getTextStyleForStatus(
      widget.post.status,
    ).color);

    final color = customTextStyle.color;

    final textStyle = styleS14W5(color);

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xff78C6E7),
        borderRadius: BorderRadius.circular(44),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 32,
            width: 32,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(44),
            ),
            child: SvgPicture.asset(
              'assets/icons/logo/mission/history.svg',
              // height: 16,
              // width: 16,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(44),
            ),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Transform.translate(
                          offset: Offset(0, -4),
                          child: Container(
                            margin: const EdgeInsets.only(right: 6),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: "${widget.post.status ?? ''}",
                        style: textStyle, // Sử dụng cùng một TextStyle
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/logo/mission/arrow_blue_background.svg',
                ),
              ],
            ),
          ),
          _buildPlusButton(context),
        ],
      ),
    );
  }

  _buildPlusButton(BuildContext context) {
    List<Mission> missions = getMissionList();
    List<String> postTitles = missions.map((mission) => mission.title).toList();
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return WorkReportContent(postTitles: postTitles);
          },
        );
      },
      child: Container(
        height: 32,
        width: 32,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(44),
        ),
        child: SvgPicture.asset(
          'assets/icons/logo/mission/add_document.svg',
        ),
      ),
    );
  }

  _buildWorkReport(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ReportDetailPage(post: widget.post);
        }));
      },
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/icons/logo/mission/work_report.svg'),
                SizedBox(width: 4),
                Text(
                  'Báo cáo công việc',
                  style: styleS16W5(Color(0xff55595D)),
                ),
                SizedBox(width: 4),
                Container(
                  //height: 18,
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: AppColors.blueText,
                    borderRadius: BorderRadius.circular(44),
                  ),
                  child: Center(
                    child: Text(
                      '2',
                      style: styleS12W4(Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildReportItems(),
            _buildReportItems(),
            SizedBox(height: 56),
          ],
        ),
      ),
    );
  }

  _buildReportItems() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white, // Màu nền trắng
        borderRadius: BorderRadius.circular(8), // Bo góc
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Màu sắc bóng
            spreadRadius: 2, // Độ lan tỏa của bóng
            blurRadius: 5, // Độ mờ của bóng
            offset: Offset(0, 2), // Vị trí bóng (x, y)
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTypeAndDate(),
          SizedBox(height: 8),
          // Text(
          //   widget.post.title ?? '',
          //   overflow: TextOverflow.ellipsis,
          //   style: styleS14W5(Colors.black).copyWith(height: 0),
          //   maxLines: 1,
          // ),
          // SizedBox(height: 8),
          Text(
            // widget.post.description ?? '',
            // overflow: TextOverflow.ellipsis,
            // style: styleS14W4(AppColors.divider).copyWith(height: 0),
            // maxLines: 1,
            'Kết quả tuần tra: Có nhiều trường hợp vi phạm về đội mũ bảo hiểm, Đã xử lý: 52 vụ, lập biên bản xử lý 42 vụ, tịch...',
            style: styleS14W4(AppColors.divider),
          ),
          SizedBox(height: 8),
          _buildStatusAndAttach(),
        ],
      ),
    );
  }

  Widget _buildTypeAndDate() {
    final textStyle =
        MissionStyleProvider.getTextStyleForStatus(widget.post.status);
    final color = textStyle.color;
    final customTextStyle = styleS14W5(color);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min, // Kích thước bằng nội dung
          children: [
            ClipRect(
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Color(0xff55595D),
                child: Image.asset(
                  'assets/images/home/feed/logo_avatar.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 6),
            Text(widget.post.username, style: styleS14W4(Colors.black)),
          ],
        ),
        Row(
          children: [
            Text(
              '1 ngày trước' ' • ',
              style: styleS12W4(AppColors.floatingLabel),
            ),
            Text(
              '26/10/2023',
              style: styleS12W5(AppColors.floatingLabel),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildStatusAndAttach() {
    final textStyle =
        MissionStyleProvider.getTextStyleForStatus(widget.post.status);
    final color = textStyle.color;
    final customTextStyle = styleS14W5(color);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Transform.translate(
                  offset: const Offset(0, -5),
                  child: Container(
                    margin: const EdgeInsets.only(right: 6),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              TextSpan(
                text: widget.post.status ?? '',
                style: customTextStyle,
              ),
            ],
          ),
        ),
        Row(
          children: [
            SvgPicture.asset(
              'assets/images/home/feed/icon_post_card_link.svg',
            ),
            SizedBox(width: 2),
            Text('2'),
          ],
        ),
      ],
    );
  }

  String formatWorkingTime(TimeOfDay startTime, TimeOfDay endTime) {
    String formattedStart = formatTimeOfDay(startTime);
    String formattedEnd = formatTimeOfDay(endTime);
    return '$formattedStart - $formattedEnd'; // Kết hợp hai thời gian
  }

  String formatTimeOfDay(TimeOfDay time) {
    // Lấy giờ và phút
    String hour =
        time.hour.toString().padLeft(2, '0'); // Thêm số 0 phía trước nếu cần
    String minute =
        time.minute.toString().padLeft(2, '0'); // Thêm số 0 phía trước nếu cần

    // Xác định AM/PM
    String period = time.hour < 12 ? 'SA' : 'CH'; // SA cho sáng, CH cho chiều

    // Đưa ra định dạng cuối cùng
    return '$hour:$minute $period';
  }
}
