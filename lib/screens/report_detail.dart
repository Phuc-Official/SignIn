import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../logics/mission_type_provider.dart';
import '../model/mission.dart';
import '../style/app_color.dart';
import '../style/app_style.dart';
import '../widget/appbar_blur.dart';

class ReportDetailPage extends StatefulWidget {
  const ReportDetailPage({
    super.key,
    required this.post,
  });
  final Mission post;

  @override
  _ReportDetailPageState createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> {
  // Thêm các biến trạng thái nếu cần
  PageController _pageController = PageController();
  int _currentIndex = 0;

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
                AppBarBlur(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPostContent(screenWidth, screenHeight),
                    SizedBox(height: 24),
                    _buildAssignedPerson(),
                    _buildTitleAndContent(),
                    SizedBox(height: 24),
                    _buildAttachFiles(),
                    SizedBox(height: 60),
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
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Chi tiết báo cáo công việc',
            style: styleS18W5(Color(0xff55595D)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  _buildPostContent(double width, double height) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTypePost(),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
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
          Row(
            children: [
              _buildInfoContainer('post.startDate as String', 'Ngày báo cáo'),
              SizedBox(width: 16),
              _buildInfoContainer('post.endDate as String', 'Thời gian'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoContainer(String timePost, String timeLabel) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.searchBar,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              timeLabel,
              style: styleS14W4(AppColors.floatingLabel),
              textAlign: TextAlign.left,
            ),
            Text(
              timePost,
              style: styleS14W6(AppColors.bgOryza),
              textAlign: TextAlign.left,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Người báo cáo', style: styleS16W5(AppColors.floatingLabel)),
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
              mainAxisSize: MainAxisSize.min,
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
                'Nội dung báo cáo',
                style: styleS16W5(AppColors.black),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
            ),
            child: Text(
              '${widget.post.description ?? ''}',
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
              'assets/icons/logo/mission/edit_report.svg',
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
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildCancelButton(context),
        ],
      ),
    );
  }

  _buildCancelButton(BuildContext context) {
    return InkWell(
      onTap: () {
        _showCustomDialog(context);
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
          'assets/icons/logo/mission/cancel_report.svg',
        ),
      ),
    );
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          child: Container(
            padding: EdgeInsets.only(bottom: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: SvgPicture.asset(
                            'assets/icons/logo/mission/icon_cancel_report.svg',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8, top: 8),
                          child: SvgPicture.asset(
                            'assets/icons/logo/mission/close.svg',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  'Bạn chắc chắn hủy phê duyệt không?',
                  style: styleS16W5(Colors.black).copyWith(height: 0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Sau khi hủy, trạng thái sẽ chuyển thành "Đã hủy".',
                  style: styleS14W4(AppColors.bgOryza).copyWith(height: 0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 34),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(134, 46),
                          backgroundColor: AppColors.whiteOryza,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child:
                            Text('Không', style: styleS16W5(AppColors.bgOryza)),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(134, 46),
                          backgroundColor: AppColors.outDate,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'Có',
                          style: styleS16W5(Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
