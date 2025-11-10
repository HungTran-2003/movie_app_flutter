import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/common/app_colors.dart';
import 'package:movie_app/common/app_dimens.dart';
import 'package:movie_app/common/app_text_styles.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/ui/pages/home/widgets/icon_label.dart';

class MovieWidget extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onPressed;

  const MovieWidget({super.key, required this.movie, this.onPressed});

  static const baseURL = "https://image.tmdb.org/t/p/w200";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 120,
              height: 102,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppDimens.imageCornerRadius,
                ),
              ),
              child: Image.network(
                "$baseURL${movie.posterPath}",
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 13.0),
            _buildInforMovie(),
          ],
        ),
      ),
    );
  }

  Widget _buildInforMovie() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          movie.title ?? "No data",
          style: AppTextStyle.whitePoppinsS16Regular,
        ),
        const SizedBox(height: 14.0),
        IconLabel(
          assetIcon: "assets/vectors/star.svg",
          label: (movie.voteAverage ?? "No data").toString(),
          color: AppColors.textOrange,
        ),
        const SizedBox(height: 4.0),
        IconLabel(
          assetIcon: "assets/vectors/ticket.svg",
          label: (movie.voteAverage ?? "No data").toString(),
          color: AppColors.textOrange,
        ),
        const SizedBox(height: 4.0),
        IconLabel(
          assetIcon: "assets/vectors/calendar_blank.svg",
          label: (movie.voteAverage ?? "No data").toString(),
          color: AppColors.textOrange,
        ),
        const SizedBox(height: 4.0),
        IconLabel(
          assetIcon: "assets/vectors/clock.svg",
          label: (movie.voteAverage ?? "No data").toString(),
          color: AppColors.textOrange,
        ),
      ],
    );
  }
}
