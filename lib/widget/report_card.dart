import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../style/app_color.dart';
import '../style/app_style.dart';
import 'button.dart';
import 'file_attach.dart';

class WorkReportContent extends StatefulWidget {
  final List<String> postTitles;

  WorkReportContent({required this.postTitles});

  @override
  _WorkReportContentState createState() => _WorkReportContentState();
}

class _WorkReportContentState extends State<WorkReportContent> {
  String? selectedTitle;
  List<Map<String, String>> attachedFiles = []; // Danh sách tệp đính kèm
  int _currentPageIndex = 0; // Chỉ số trang hiện tại

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 11),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 4,
                width: 56,
                decoration: BoxDecoration(
                  color: Color(0xffA7A7A7),
                  borderRadius: BorderRadius.circular(44),
                ),
              ),
            ),
            SizedBox(height: 22),
            _reportTitle(context),
            SizedBox(height: 24),
            _buildListWork(),
            SizedBox(height: 24),
            _buildAttachFiles(),
            SizedBox(height: 24),
            _buildButtonSubmit(context),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _reportTitle(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                'Huỷ bỏ',
                style: styleS14W4(Color(0xff55595D)),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Báo cáo công việc',
              textAlign: TextAlign.center,
              style: styleS18W5(Color(0xff1C2A53)),
            ),
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget _buildListWork() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(" 1. Công việc", style: styleS14W4(AppColors.bgOryza)),
        SizedBox(height: 6),
        DropdownButton<String>(
          value: selectedTitle,
          hint: Text('Chọn công việc', style: styleS16W4(Colors.black)),
          isExpanded: true,
          onChanged: (String? newValue) {
            setState(() {
              selectedTitle = newValue;
            });
          },
          items:
              widget.postTitles.map<DropdownMenuItem<String>>((String title) {
            return DropdownMenuItem<String>(
              value: title,
              child: Text(title, style: styleS16W4(Colors.black)),
            );
          }).toList(),
        ),
        SizedBox(height: 24),
        Text(" 2. Nội dung báo cáo", style: styleS14W4(AppColors.bgOryza)),
        SizedBox(height: 6),
        TextField(
          keyboardType: TextInputType.multiline,
          minLines: 4,
          maxLines: null,
          decoration: InputDecoration(
            hintStyle: styleS16W4(AppColors.floatingLabel),
            hintText: 'Nhập nội dung báo cáo',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppColors.border, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppColors.blueTop, width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildAttachFiles() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16).copyWith(left: 16),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/icons/logo/mission/attach_file.svg'),
                  SizedBox(width: 4),
                  Text('Tệp đính kèm', style: styleS14W5(AppColors.bgOryza)),
                  SizedBox(width: 4),
                  if (attachedFiles.isNotEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.blueText,
                        borderRadius: BorderRadius.circular(44),
                      ),
                      child: Center(
                        child: Text(
                          attachedFiles.length.toString(),
                          style: styleS12W4(Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
              GestureDetector(
                onTap: _addFile, // Mở trình chọn tệp
                child: Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: SvgPicture.asset(
                    'assets/icons/logo/mission/plus_blue.svg',
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
            ],
          ),
          // Hiển thị các tệp đính kèm
          if (attachedFiles.isNotEmpty) ...[
            Container(
              height: 220,
              child: PageView.builder(
                itemCount: attachedFiles.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index; // Cập nhật chỉ số trang hiện tại
                  });
                },
                itemBuilder: (context, index) {
                  final file = attachedFiles[index];
                  return FileAttachmentWidget(
                    title: file['title'] ?? 'Unnamed File',
                    imagePath: file['imagePath'] ?? '',
                    onDelete: () => _removeFile(file),
                    currentIndex: index,
                    itemCount: attachedFiles.length,
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(attachedFiles.length, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPageIndex == index
                        ? AppColors.hintText
                        : AppColors.white,
                  ),
                );
              }),
            ),
          ] else ...[
            SizedBox(),
          ],
        ],
      ),
    );
  }

  void _addFile() async {
    // Cho phép chọn nhiều loại tệp
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true, // Cho phép chọn nhiều tệp
      type: FileType.custom, // Chọn loại tệp tùy chỉnh
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'pdf',
        'doc',
        'docx'
      ], // Các loại tệp cho phép
    );

    if (result != null) {
      for (var file in result.files) {
        if (file.path != null) {
          String fileName = file.name;
          String filePath = file.path!;

          setState(() {
            attachedFiles.add({
              'title': fileName,
              'imagePath': filePath, // Lưu đường dẫn hình ảnh
            });
          });
        }
      }
    }
  }

  void _removeFile(Map<String, String> file) {
    setState(() {
      attachedFiles.remove(file); // Xóa tệp khỏi danh sách
      // Cập nhật lại chỉ số trang nếu xóa trang hiện tại
      if (_currentPageIndex >= attachedFiles.length) {
        _currentPageIndex = attachedFiles.length - 1;
      }
    });
  }

  Widget _buildButtonSubmit(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ButtonWidget(
            borderCircular: 11,
            title: 'Gửi duyệt',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
