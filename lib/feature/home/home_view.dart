import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/feature/home/sub_view/home_search_delegate.dart';
import 'package:flutter_application_firebase/feature/home_create/home_create_view.dart';
import 'package:flutter_application_firebase/product/constants/color_constants.dart';
import 'package:flutter_application_firebase/product/constants/string_constants.dart';
import 'package:flutter_application_firebase/product/models/tag.dart';
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
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      ref.read(homeProvider.notifier).fetchAndLoad();
    });

    ref.read(homeProvider.notifier).addListener((state) {
      if (state.selectedTag != null) {
        _controller.text = state.selectedTag?.name ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var response = await context.navigateToPage<bool>(HomeCreateView(),
              type: SlideType.RIGHT);
          if (response ?? false) {
            ref.read(homeProvider.notifier).fetchAndLoad();
          }
        },
      ),
      body: SafeArea(
        child: Material(
          child: Stack(
            children: [
              ListView(
                padding: context.paddingNormal,
                children: [
                  _Header(),
                  _CustomTextField(
                    controller: _controller,
                  ),
                  _TagListView(),
                  _BrowseHorizontalListView(),
                  _RecommendedHeader(),
                  _RecommendedListView(),
                  _BottomText()
                  // HomeListView()
                ],
              ),
              if (ref.watch(homeProvider).isLoading ?? false)
                const Center(
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomText extends StatelessWidget {
  const _BottomText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "data",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _CustomTextField extends ConsumerWidget {
  const _CustomTextField({
    required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        controller: controller,
        onTap: () async {
          final result = await showSearch(
              context: context,
              delegate: HomeSearchDelegate(
                ref.read(homeProvider.notifier).fullTagList,
              ));
          ref.read(homeProvider.notifier).updateSelectedTag(result);
        },
        decoration: const InputDecoration(
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
class _RecommendedListView extends ConsumerWidget {
  const _RecommendedListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommended = ref.watch(homeProvider).recommended;
    return ListView.builder(
      itemCount: recommended?.length ?? 0,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final recommendedItem = recommended?[index];
        return ListTile(
          leading: Image.network(recommendedItem?.image ?? ''),
          title: Text(recommendedItem?.title ?? ''),
          subtitle: Text(recommendedItem?.description ?? ''),
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
    print("data: $newsItems");

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

class _TagListView extends ConsumerWidget {
  const _TagListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagItems = ref.watch(homeProvider).tags;
    return SizedBox(
      height: context.dynamicHeight(.1),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tagItems?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          final tagItem = tagItems?[index];
          if (tagItem?.active ?? false) return _ActiveChip(tagItem);
          return _PassiveChip(tagItem);
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
