import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/common/app_colors.dart';
import 'package:movie_app/common/app_text_styles.dart';

class IconLabel extends StatelessWidget {
  final String assetIcon;
  final String label;
  final Color color;

  const IconLabel({
    super.key,
    required this.assetIcon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          assetIcon,
          width: 16,
          height: 16,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
        ?_buildLabelWidget(),
      ],
    );
  }

  Widget? _buildLabelWidget() {
    if (color == AppColors.textOrange) {
      return Text(label, style: AppTextStyle.orangeMontS12SemiBold, overflow: TextOverflow.ellipsis);
    }
    if (color == AppColors.textGray) {
      return Text(label, style: AppTextStyle.grayMontS12Medium, overflow: TextOverflow.ellipsis);
    }
    if (color == AppColors.textWhite) {
      return Text(label, style: AppTextStyle.whitePoppinsS12Regular, overflow: TextOverflow.ellipsis);
    }
    return null;
  }
}
