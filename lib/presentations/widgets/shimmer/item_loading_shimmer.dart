import 'package:dmart_android_flutter/presentations/widgets/shimmer/placeholders.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemLoadingShimmer extends StatelessWidget {
  const ItemLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            // BannerPlaceholder(),
            TitlePlaceholder(width: double.infinity),
          ],
        ),
      ),
    );
  }
}
