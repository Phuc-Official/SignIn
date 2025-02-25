import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';

import '../style/app_color.dart';
import '../style/app_style.dart';

class FileAttachmentWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onDelete;
  final int currentIndex; // Chỉ số hiện tại
  final int itemCount; // Số lượng file

  FileAttachmentWidget({
    required this.title,
    required this.imagePath,
    required this.onDelete,
    required this.currentIndex, // Nhận chỉ số hiện tại
    required this.itemCount, // Nhận số lượng item
  });

  String getFileIcon(String fileExtension) {
    switch (fileExtension.toLowerCase()) {
      case 'pdf':
        return 'assets/icons/logo/mission/file/pdf.svg';
      case 'doc':
      case 'docx':
        return 'assets/icons/logo/mission/file/word.svg';
      case 'xls':
      case 'xlsx':
        return 'assets/icons/logo/mission/file/excel.svg';
      case 'jpg':
      case 'jpeg':
      case 'png':
        return 'assets/icons/logo/mission/file/image.svg';
      default:
        return 'assets/icons/logo/mission/file/unknown.svg'; // Biểu tượng cho loại tệp không xác định
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lấy phần mở rộng từ tiêu đề
    String fileExtension = title.split('.').last;
    String iconPath = getFileIcon(fileExtension);

    return Container(
      margin: EdgeInsets.only(right: 16, top: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: -5,
            blurRadius: 15,
            offset: Offset(2, 2),
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
                  SvgPicture.asset(iconPath, width: 24, height: 24),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    width: 1,
                    height: 16,
                    decoration: BoxDecoration(color: Color(0xFFE2E5E4)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      title,
                      style: styleS14W4(AppColors.bgOryza),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onDelete,
                child: SvgPicture.asset(
                  'assets/icons/logo/mission/delete.svg',
                  width: 18,
                  height: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Container(
                width: double.infinity,
                child: _buildFileContent(fileExtension),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileContent(String fileExtension) {
    // Kiểm tra phần mở rộng và hiển thị nội dung tương ứng
    if (['jpg', 'jpeg', 'png'].contains(fileExtension.toLowerCase())) {
      return imagePath.isNotEmpty
          ? Image.file(
              File(imagePath),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            )
          : Container(
              color: Colors.grey,
              child: Center(child: Text('Không có hình ảnh')),
            );
    } else if (fileExtension.toLowerCase() == 'pdf') {
      return _buildPdfThumbnail();
    } else if (['doc', 'docx', 'xls', 'xlsx']
        .contains(fileExtension.toLowerCase())) {
      return Container(
        color: Colors.grey[300],
        child: Center(
          child: Text(
            'Xem trước không khả dụng',
            style: TextStyle(color: Colors.black54),
          ),
        ),
      );
    } else {
      return Container(
        color: Colors.grey[300],
        child: Center(
          child: Text('Loại tệp không được hỗ trợ'),
        ),
      );
    }
  }

  Widget _buildPdfThumbnail() {
    // Hiển thị hình ảnh từ trang đầu tiên của PDF
    return FutureBuilder(
      future: _getPdfThumbnail(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Không thể tải hình ảnh'));
        } else {
          return snapshot.data != null
              ? Image.file(
                  File(snapshot.data!),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                )
              : Container(
                  color: Colors.grey,
                  child: Center(child: Text('Không có hình ảnh')),
                );
        }
      },
    );
  }

  Future<String?> _getPdfThumbnail() async {
    //final document = await PdfDocument.openFile(imagePath);
    //final page = await document.getPage(1);
    //final image = await page.render(width: 200, height: 200);
    final imagePath = '${(await getTemporaryDirectory()).path}/thumbnail.png';
    final file = File(imagePath);
    //await file.writeAsBytes(image!);
    return imagePath;
  }
}
