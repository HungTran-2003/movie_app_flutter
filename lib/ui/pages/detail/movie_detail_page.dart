import 'package:flutter/material.dart';
import 'package:movie_app/common/app_colors.dart';
import 'package:movie_app/common/app_dialogs.dart';
import 'package:movie_app/common/app_dimens.dart';
import 'package:movie_app/common/app_svgs.dart';
import 'package:movie_app/common/app_text_styles.dart';
import 'package:movie_app/database/app_share_preferences.dart';
import 'package:movie_app/models/entities/movie/movie_entity.dart';
import 'package:movie_app/models/response/error_response.dart';
import 'package:movie_app/service/movie_service.dart';
import 'package:movie_app/ui/pages/home/widgets/icon_label.dart';
import 'package:movie_app/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:movie_app/ui/widgets/images/app_cache_images.dart';
import 'package:movie_app/ui/widgets/loading/app_loading_indicator.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.movieId});

  final int movieId;

  @override
  State<MovieDetailPage> createState() => _StateScreen1();
}

class _StateScreen1 extends State<MovieDetailPage> {
  final _prefs = AppSharePreferences.instance;
  bool _isLoading = true;
  MovieEntity? movie;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = _prefs.contains(widget.movieId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadDetailMovie();
    });
  }

  void loadDetailMovie() async {
    try {
      final fetchMovie = await MovieService.instance.fetchDetailMovie(
        widget.movieId,
      );
      setState(() {
        movie = fetchMovie;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      if (e is ErrorResponse) {
        AppDialogs(context: context).showSimpleDialog(
          title: "Error: ${e.statusCode}",
          content: e.statusMessage,
        );
      } else {
        AppDialogs(
          context: context,
        ).showSimpleDialog(title: "Error System", content: e.toString());
      }
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
              setState(() {
                _isFavorite = !_isFavorite;
                if (_isFavorite) {
                  _prefs.addId(widget.movieId);
                } else {
                  _prefs.removeId(widget.movieId);
                }
              });
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content:
                    Text(
                      _isFavorite
                          ? "Movie added to favorites"
                          : "Movie removed from favorites",
                    ),
                    backgroundColor: _isFavorite ? Colors.green : Colors.red,
                  ),
                );
            },
            icon: Icon(
                _isFavorite ? Icons.bookmark : Icons.bookmark_outline_rounded,
                size: 24, color:
            Colors.white),
          ),
        ],
      ),
      body: _buildBodyPages(movie, maxWidth),

    );
  }

  Widget _buildBodyPages(MovieEntity? movie, double maxWidth) {
    switch (_isLoading) {
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
              MovieImages(movie: movie!),
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
  const MovieImages({super.key, required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppCacheImage(
          url: movie.backdropPath ?? "",
          width: MediaQuery.of(context).size.width,
          borderRadius: AppDimens.imageCornerRadius,
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          left: 24,
          bottom: -60,
          child: AppCacheImage(
            url: movie.posterPath ?? "",
            width: 100,
            height: 120,
            borderRadius: AppDimens.imageCornerRadius,
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

  final MovieEntity movie;
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
              VerticalDivider(thickness: 1, color: AppColors.textGray),
              IconLabel(
                assetIcon: AppSVGs.icClock,
                label: "${movie.duration ?? "N/A"} minutes",
                color: AppColors.textGray,
              ),
              VerticalDivider(thickness: 1, color: AppColors.textGray),
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
