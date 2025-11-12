import 'package:flutter/material.dart';
import 'package:movie_app/common/app_colors.dart';
import 'package:movie_app/common/app_dimens.dart';
import 'package:movie_app/common/app_svgs.dart';
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
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppDimens.imageCornerRadius),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            SizedBox(
              width: 102,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  AppDimens.imageCornerRadius,
                ),
                child: Image.network(
                  "$baseURL${movie.posterPath}",
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            const SizedBox(width: 13.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_buildInforMovie()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInforMovie() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title ?? "No data",
          style: AppTextStyle.whitePoppinsS16Regular,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(height: 14.0),
        IconLabel(
          assetIcon: AppSVGs.icStar,
          label: movie.voteAverage != null
              ? movie.voteAverage!.toStringAsFixed(1)
              : "No data",
          color: AppColors.textOrange,
        ),
        const SizedBox(height: 4.0),
        IconLabel(
          assetIcon: AppSVGs.icTicket,
          label: movie.genres?.first.name ?? "No data",
          color: AppColors.textWhite,
        ),
        const SizedBox(height: 4.0),
        IconLabel(
          assetIcon: AppSVGs.icCalendar,
          label: movie.releaseDate?.substring(0, 4) ?? "No data",
          color: AppColors.textWhite,
        ),
        const SizedBox(height: 4.0),
        IconLabel(
          assetIcon: AppSVGs.icClock,
          label: (movie.duration ?? "No data").toString(),
          color: AppColors.textWhite,
        ),
      ],
    );
  }
}
