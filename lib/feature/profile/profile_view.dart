import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/product/enums/image_constants.dart';
import 'package:flutter_application_firebase/product/widget/circle_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _Header(),
              Padding(
                padding: EdgeInsets.all(40.0),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _NameAndTitleWidget(),
                    SizedBox(height: 30),
                    _LocationWidget(),
                    SizedBox(height: 30),
                    _AboutWidget(),
                    SizedBox(height: 30),
                    _InterestWidget()
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class _InterestWidget extends StatelessWidget {
  const _InterestWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Interest",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [
            for (int i = 0; i < 5; i++)
              Container(
                width: 90,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE94057), width: 1),
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xffE8E6EA)),
                child: Center(child: Text("Travelling")),
              )
          ],
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image.asset(IconConstants.profileDummy.toPng),
        Positioned(
          bottom: -25,
          right: 0,
          left: 0,
          child: Container(
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          ),
        ),
        Positioned(
          bottom: -20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleButton(
                onTap: () {},
                size: 78,
                image: Image.asset(
                  IconConstants.dislike.toPng,
                  width: 15,
                  height: 15,
                  fit: BoxFit.fill,
                ),
              ),
              CircleButton(
                onTap: () {},
                size: 99,
                color: Color(0xffE94057),
                image: Image.asset(
                  IconConstants.heart.toPng,
                  width: 42,
                  height: 36,
                  fit: BoxFit.fill,
                ),
              ),
              CircleButton(
                onTap: () {},
                size: 78,
                image: Image.asset(
                  IconConstants.superLike.toPng,
                  width: 25,
                  height: 24,
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class _AboutWidget extends StatelessWidget {
  const _AboutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("About",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        SizedBox(
          height: 5,
        ),
        Text(
            "My name is Jessica Parker and I enjoy meeting new people and finding ways to help them have an uplifting experience. I enjoy reading.."),
        Text(
          "Read More",
          style:
              TextStyle(fontWeight: FontWeight.w700, color: Color(0xffE94057)),
        ),
      ],
    );
  }
}

class _LocationWidget extends StatelessWidget {
  const _LocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Location",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Chicago, IL United States",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Color(0xffE94057).withOpacity(0.1),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Color(0xffE94057),
                  ),
                  Text(
                    "1 km ",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Color(0xffE94057),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _NameAndTitleWidget extends StatelessWidget {
  const _NameAndTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Jessica Parker, 23",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            Text(
              "Proffesional model",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        Image.asset(
          IconConstants.btnSend.toPng,
          width: 52,
          fit: BoxFit.cover,
        )
      ],
    );
  }
}
