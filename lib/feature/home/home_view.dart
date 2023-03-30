import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/product/constants/color_constants.dart';
import 'package:flutter_application_firebase/product/constants/string_constants.dart';
import 'package:flutter_application_firebase/product/widget/home_news_card.dart';
import 'package:flutter_application_firebase/product/widget/sub_title_text.dart';
import 'package:flutter_application_firebase/product/widget/title_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import 'home_provider.dart';

part 'sub_view/home_chips.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

class HomeView extends ConsumerStatefulWidget {
  HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(homeProvider.notifier).fetchAndLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Material(
          child: ListView(
            padding: context.paddingNormal,
            children: const [
              _Header(),
              _CustomTextField(),
              _TagListView(),
              _BrowseHorizontalListView(),
              _RecommendedHeader(),
              _RecommendedListView(),
              // HomeListView()
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  const _CustomTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search_outlined),
            suffixIcon: Icon(Icons.mic_outlined),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: ColorConstants.grayLighter,
            hintText: "Search"),
      ),
    );
  }
}

class _RecommendedHeader extends StatelessWidget {
  const _RecommendedHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TitleText(text: "Recommended for you"),
        ),
        TextButton(
          onPressed: () {},
          child: SubTitleText(text: "See All"),
        )
      ],
    );
  }
}

//45:52 part 6 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
class _RecommendedListView extends StatelessWidget {
  const _RecommendedListView({
    super.key,
  });

  static const dummyRecommendImageUrl =
      "https://firebasestorage.googleapis.com/v0/b/flutterdenem.appspot.com/o/recommendbg.png?alt=media&token=c81f6902-6daf-489d-8c3d-aa718bf812c9";

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.network(dummyRecommendImageUrl),
          title: Text("UI/UX Design"),
          subtitle: Text(
              "A Simple Trick Forcdd dddfsdfs dfsdfsdfdsfds Creating Color Palettes Quickly"),
        );
        /**
        Padding(
          padding: context.onlyTopPaddingMedium,
          child: Row(
            children: [
              Image.network(
                dummyRecommendImageUrl,
                height: context.dynamicHeight(.1),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubTitleText(
                      text: "UI/UX Design",
                      color: ColorConstants.grayPrimary,
                      textStyle: context.textTheme.titleSmall,
                    ),
                    TitleText(
                      text:
                          "A Simple Trick For Creating Color Palettes Quickly",
                      textStyle: context.textTheme.titleSmall,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
         * 
         */
      },
    );
  }
}

class _BrowseHorizontalListView extends ConsumerWidget {
  const _BrowseHorizontalListView({
    super.key,
  });

  static const dummyImage =
      'https://firebasestorage.googleapis.com/v0/b/flutterdenem.appspot.com/o/nuntium_news_home.png?alt=media&token=acaba2c9-9340-4302-8e4f-2c400467b275';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsItems = ref.watch(homeProvider).news ?? [];
    return SizedBox(
      height: context.dynamicHeight(.3),
      child: ListView.builder(
        itemCount: newsItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return HomeNewsCard(newsItem: newsItems[index]);
        },
      ),
    );
  }
}

class _TagListView extends StatelessWidget {
  const _TagListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(.1),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          if (index.isOdd) return _ActiveChip();
          return _PassiveChip();
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          text: StringConstants.browse,
        ),
        Padding(
          padding: context.onlyTopPaddingLow,
          child: SubTitleText(
            text: 'Discover things of this world',
          ),
        ),
      ],
    );
  }
}
