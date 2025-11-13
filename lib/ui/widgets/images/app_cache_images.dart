import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/ui/widgets/loading/app_loading_indicator.dart';

class AppCacheImage extends StatelessWidget {
  final String url;
  final double width;
  final double? height;
  final BoxFit? fit;
  final double borderRadius;

  const AppCacheImage({
    super.key,
    required this.url,
    required this.width,
    this.height,
    this.fit,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 210,
      decoration: BoxDecoration(
        borderRadius: fit == null
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.only(
                bottomLeft: Radius.circular(borderRadius),
                bottomRight: Radius.circular(borderRadius),
              ),
      ),
      child: ClipRRect(
        borderRadius: fit == null
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.only(
                bottomLeft: Radius.circular(borderRadius),
                bottomRight: Radius.circular(borderRadius),
              ),
        child: CachedNetworkImage(
          imageUrl: url,
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return AppCircularProgressIndicator();
          },
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: fit ?? BoxFit.fill,
        ),
      ),
    );
  }
}
