
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/common/app_colors.dart';
import 'package:movie_app/common/app_dimens.dart';
import 'package:movie_app/common/app_svgs.dart';
import 'package:movie_app/common/app_text_styles.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/service/movie_service.dart';
import 'package:movie_app/ui/pages/home/widgets/icon_label.dart';
import 'package:movie_app/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:movie_app/ui/widgets/loading/app_loading_indicator.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.movieId});

  final int movieId;

  @override
  State<MovieDetailPage> createState() => _StateScreen1();
}

class _StateScreen1 extends State<MovieDetailPage> {
  static const baseURL = "https://image.tmdb.org/t/p/original";
  bool _isLoading = true;
  Movie? movie;

  @override
  void initState() {
    super.initState();
    loadDetailMovie();
  }

  void loadDetailMovie() async{
    try{
      final fetchMovie = await MovieService.instance.fetchDetailMovie(widget.movieId);
      setState(() {
        movie = fetchMovie;
      _isLoading = false;
      });
    } catch(e) {
      log(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarWidget(
        title: "Detail",
        onPressed: () {
          Navigator.pop(context);
        },
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: Icon(Icons.bookmark, size: 24, color: Colors.white),
          ),
        ],
      ),
      body: _buildBodyPages(movie, maxWidth),
    );
  }

  Widget _buildBodyPages(Movie? movie, double maxWidth) {
    switch(_isLoading){
      case false:
        final lines = getNumberOfLines(
          text: movie?.title ?? "N/A",
          style: AppTextStyle.whitePoppinsS18SemiBold,
          maxWidth: maxWidth - 134 - 16,
        );
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MovieImages(baseURL: baseURL, movie: movie!),
              Container(
                padding: const EdgeInsets.only(left: 134, top: 12, right: 16),
                child: Text(
                  movie.title ?? "N/A",
                  style: AppTextStyle.whitePoppinsS18SemiBold,
                  softWrap: true,
                ),
              ),

              MovieDetailsSection(movie: movie, lines: lines),

              Container(
                width: maxWidth,
                padding: const EdgeInsets.only(left: 24, top: 24, right: 19),
                child: Text(
                  movie.overview ?? "N/A",
                  style: AppTextStyle.whitePoppinsS12Regular,
                  softWrap: true,
                ),
              ),
            ],
          ),
        );
      case true:
        return Center(child: AppCircularProgressIndicator());
    }
  }

  int getNumberOfLines({
    required String text,
    required TextStyle style,
    required double maxWidth,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: maxWidth);

    return textPainter.computeLineMetrics().length;
  }
}

class MovieImages extends StatelessWidget {
  const MovieImages({super.key, required this.baseURL, required this.movie});

  final String baseURL;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(AppDimens.imageCornerRadius),
            bottomRight: Radius.circular(AppDimens.imageCornerRadius),
          ),
          child: Image.network(
            "$baseURL${movie.backdropPath}",
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          left: 24,
          bottom: -60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.imageCornerRadius),
            child: Image.network(
              "$baseURL${movie.posterPath}",
              width: 100,
              height: 120,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          right: 13,
          bottom: 8,
          child: Container(
            height: 24,
            width: 54,
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(AppDimens.imageCornerRadius),
            ),
            child: Center(
              child: IconLabel(
                assetIcon: AppSVGs.icStar,
                label: movie.voteAverage != null
                    ? movie.voteAverage!.toStringAsFixed(1)
                    : "N/A",
                color: AppColors.textOrange,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MovieDetailsSection extends StatelessWidget {
  const MovieDetailsSection({
    super.key,
    required this.movie,
    required this.lines,
  });

  final Movie movie;
  final int lines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: lines == 1 ? 40 : 16),
      child: Center(
        child: SizedBox(
          height: 16,
          child: Row(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconLabel(
                assetIcon: AppSVGs.icCalendar,
                label: movie.releaseDate?.substring(0, 4) ?? "N/A",
                color: AppColors.textGray,
              ),
              VerticalDivider(thickness: 1, color: AppColors.textGray,),
              IconLabel(
                assetIcon: AppSVGs.icClock,
                label: "${movie.duration ?? "N/A"} minutes",
                color: AppColors.textGray,
              ),
              VerticalDivider(thickness: 1, color: AppColors.textGray,),
              IconLabel(
                assetIcon: AppSVGs.icTicket,
                label: movie.genres?.first.name ?? "N/A",
                color: AppColors.textGray,
              ),

            ],
          ),
        ),
      ),
    );
  }
}