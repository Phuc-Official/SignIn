import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../logics/check_type.dart';
import '../logics/mission_type_provider.dart';
import '../model/mission.dart';
import '../screens/mission_detail.dart';
import '../style/app_color.dart';
import '../style/app_style.dart';

class MissionCardAndInfo extends StatefulWidget {
  const MissionCardAndInfo({
    super.key,
    required this.post,
    this.onSelect,
    this.isChecked,
    this.missionStatus,
    this.missionType,
  });

  final Mission post;
  final Function(bool)? onSelect; // Callback để gửi trạng thái đã chọn
  final bool? isChecked;
  final String? missionStatus;
  final MissionType? missionType;

  @override
  State<MissionCardAndInfo> createState() => _MissionCardAndInfoState();
}

class _MissionCardAndInfoState extends State<MissionCardAndInfo> {
  late bool isCheck;

  @override
  void initState() {
    super.initState();
    isCheck = widget.isChecked!;
  }

  @override
  void didUpdateWidget(MissionCardAndInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isChecked != widget.isChecked) {
      setState(() {
        isCheck = widget.isChecked!; // Cập nhật khi trạng thái thay đổi
      });
    }
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
    final missionType =
        _getMissionType(widget.post.type); // Lấy MissionType dựa trên type

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MissionDetailPage(post: widget.post);
        }));
      },
      // onLongPress: () {
      //   setState(() {
      //     isCheck = !isCheck;
      //     widget.onSelect!(isCheck); // Gọi callback với trạng thái hiện tại
      //   });
      // },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 0),
            padding: const EdgeInsets.all(12),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 22),
                  height: 88,
                  width: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.searchBar,
                  ),
                  child: ClipRRect(
                    child: missionType?.icon != null
                        ? SvgPicture.asset(
                            missionType!.icon!,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 72,
                            height: 88,
                            color: Colors.grey,
                          ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 88,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTypeAndTimeLeft(),
                        Text(
                          widget.post.title ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: styleS14W5(Colors.black).copyWith(height: 0),
                          maxLines: 2,
                        ),
                        _buildStatusAndAttach(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //if (isCheck) _buildCheckPost(),
        ],
      ),
    );
  }

  Widget _buildTypeAndTimeLeft() {
    final textStyle =
        MissionStyleProvider.getTextStyleForStatus(widget.post.status);
    final color = textStyle.color;
    final customTextStyle = styleS14W5(color);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: MissionStyleProvider.getBackgroundColorForType(
                widget.post.type),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            widget.post.type,
            style: MissionStyleProvider.getTextStyleForType(widget.post.type),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: MissionStyleProvider.getBackgroundColorForTimeLeft(
                widget.post.timeLeft),
            borderRadius: BorderRadius.circular(44),
          ),
          child: Text(
            widget.post.timeLeft,
            style: MissionStyleProvider.getTextStyleForTimeLeft(
                widget.post.timeLeft),
          ),
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
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
        Spacer(),
        SvgPicture.asset('assets/images/home/feed/icon_post_card_link.svg'),
        SizedBox(width: 4),
        Transform.translate(
          offset: Offset(0, 2),
          child: Text("2"),
        ),
        SizedBox(width: 8),
        SvgPicture.asset('assets/icons/logo/mission/document.svg'),
        SizedBox(width: 4),
        Transform.translate(
          offset: Offset(0, 2),
          child: Text("1"),
        ),
      ],
    );
  }

  Widget _buildCheckPost() {
    return Positioned(
      left: 10,
      top: 13,
      child: Container(
        height: 16,
        width: 16,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: const Color(0xff007DC0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(
          Icons.check,
          size: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
