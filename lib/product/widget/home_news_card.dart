import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/product/constants/color_constants.dart';
import 'package:flutter_application_firebase/product/models/news.dart';
import 'package:flutter_application_firebase/product/widget/sub_title_text.dart';
import 'package:kartal/kartal.dart';

class HomeNewsCard extends StatelessWidget {
  const HomeNewsCard({
    super.key,
    required this.newsItem,
  });

  final News newsItem;

  @override
  Widget build(BuildContext context) {
    if (newsItem == null) return const SizedBox.shrink();
    return Stack(
      children: [
        Padding(
          padding: context.onlyRightPaddingNormal,
          child: Image.network(
            newsItem.backgroundImage ?? '',
            errorBuilder: (context, error, stackTrace) => const Placeholder(),
          ),
        ),
        Positioned.fill(
          // ??????
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: context.onlyRightPaddingLow,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_outline),
                  color: ColorConstants.white,
                ),
              ),
              Spacer(),
              Padding(
                padding: context.paddingLow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubTitleText(
                      text: newsItem.category ?? '',
                      color: ColorConstants.white,
                    ),
                    SubTitleText(
                      text: newsItem.title ?? '',
                      color: ColorConstants.white,
                      textStyle: context.textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
