import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../style/app_color.dart';
import '../style/app_style.dart';

class SearchFeed extends StatelessWidget {
  const SearchFeed({super.key, this.hintText, this.onFilterTap});
  final String? hintText;
  final Function? onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
      padding: const EdgeInsets.only(left: 24, right: 4),
      decoration: BoxDecoration(
        color: AppColors.searchBar,
        borderRadius: BorderRadius.circular(44),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/images/home/feed/icon_search.svg'),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  // suffixIcon: _buildFilterIcon(),
                  hintText: hintText ?? 'Tìm kiếm...',
                  border: InputBorder.none,
                  hintStyle: styleS16W4(
                    Color(0xff808080),
                  )),
            ),
          ),
          //_buildFilterIcon(),
        ],
      ),
    );
  }

  _buildFilterIcon() {
    return GestureDetector(
      onTap: () {
        if (onFilterTap != null) {
          onFilterTap!();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Color(0xff007DC0),
          borderRadius: BorderRadius.circular(44),
        ),
        child: SvgPicture.asset(
          'assets/images/home/feed/icon_search_slider.svg',
          color: Colors.white,
        ),
      ),
    );
  }
}
