import 'dart:math' as math;
import 'package:coffee_app/Controller/animationcontroller.dart';
import 'package:coffee_app/Model/coffee.dart';
import 'package:coffee_app/View/Style/colors.dart';
import 'package:coffee_app/View/Custom/background_paint.dart';
import 'package:coffee_app/Controller/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoffeeApp extends StatefulWidget {
  const CoffeeApp({Key? key}) : super(key: key);

  @override
  State<CoffeeApp> createState() => _CoffeeAppState();
}

class _CoffeeAppState extends State<CoffeeApp> with TickerProviderStateMixin {
  ValueNotifier<int> count = ValueNotifier<int>(0);
  ValueNotifier<int> currentIndex = ValueNotifier<int>(0);
  late AnimationController controller;
  late PageController pagecontroller;
  int loopIndex = 0;

  @override
  void initState() {
    PainterAnimationController().animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300));
    pagecontroller = PageController(
      initialPage: coffee.length * 10000,
      viewportFraction: 0.4,
    );
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 100));
    pagecontroller.addListener(() {
      if ((pagecontroller.page! % pagecontroller.page!.toInt()) < 0.2) {
        PainterAnimationController().reverse(() {});
        // PainterAnimationController().animationController.value = (pagecontroller.page! % pagecontroller.page!.toInt()) * 0.5;
      }
      if ((pagecontroller.page! % pagecontroller.page!.toInt()) >= 0.2) {
        PainterAnimationController().forward(() {});
        // PainterAnimationController().animationController.value = (pagecontroller.page! % pagecontroller.page!.toInt());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: SyzColors.blackS3,
      body: SizedBox.expand(
        child: CustomPaint(
          painter: BackgroundPainter(
              PainterAnimationController().animationController, loopIndex),
          child: Column(
            children: [
              Flexible(
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    'Take a Coffeé',
                    style: TextStyle(
                      fontFamily: 'futura',
                      fontSize: 29,
                      color: SyzColors.orangeS2,
                    ),
                  ),
                  centerTitle: false,
                ),
              ),
              Flexible(
                flex: 4,
                child: ValueListenableBuilder<int>(
                    valueListenable: currentIndex,
                    builder: (context, i, _) {
                      return PageView.builder(
                          allowImplicitScrolling: true,
                          controller: pagecontroller,
                          onPageChanged: (index) {
                            loopIndex = index % coffee.length;
                            currentCoffee.value = coffee[loopIndex];
                            currentIndex.value = loopIndex;
                          },
                          itemBuilder: (context, index) {
                            int loopIndex = index % coffee.length;
                            final data = coffee[loopIndex];
                            bool isActive = currentIndex.value == loopIndex;
                            double scale = isActive ? 1 : 0.7;
                            return TweenAnimationBuilder(
                                duration: const Duration(milliseconds: 500),
                                tween: Tween<double>(begin: scale, end: scale),
                                builder: (context, v, _) {
                                  return SizedBox(
                                    height: context.height * 0.4,
                                    child: FittedBox(
                                      child: Opacity(
                                        opacity: v,
                                        child: Transform.scale(
                                          scale: v * 2,
                                          child: Image.asset(
                                            data.path,
                                            fit: BoxFit.contain,
                                            height: context.height * 0.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          });
                    }),
              ),
              Flexible(
                flex: 1,
                child: ValueListenableBuilder<int>(
                  valueListenable: count,
                  builder: (context, value, child) {
                    return ValueListenableBuilder(
                        valueListenable: currentCoffee,
                        builder: (context, object, _) {
                          return SizedBox.expand(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  bottom: context.paddingBottom),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: SyzColors.blackS3.withOpacity(.5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(.5),
                                          blurStyle: BlurStyle.outer,
                                          blurRadius: 10)
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Row(
                                        children: [
                                          AbsorbPointer(
                                            absorbing: count.value == 0,
                                            child: IconButton(
                                                onPressed: () {
                                                  if (count.value > 0) {
                                                    count.value--;
                                                  }
                                                },
                                                icon: count.value != 0
                                                    ? Icon(CupertinoIcons.minus,
                                                        color: SyzColors.orangeS2)
                                                    : const SizedBox()),
                                          ),
                                          AbsorbPointer(
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: Text(
                                                count.value.toString(),
                                                style: TextStyle(
                                                  fontFamily: 'futura',
                                                  fontSize: 20,
                                                  color: SyzColors.orangeS2,
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                count.value++;
                                              },
                                              icon: Icon(CupertinoIcons.add,
                                                  color: SyzColors.orangeS2))
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Flexible(
                                            child: FittedBox(
                                              child: Center(
                                                child: Text(
                                                  object.name,
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    fontFamily: 'futura',
                                                    fontSize: 20,
                                                    color: SyzColors.orangeS2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: FittedBox(
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        CupertinoIcons.heart,
                                                        color: SyzColors.orangeS2,
                                                      )),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(CupertinoIcons.bag,
                                                          color: SyzColors.orangeS2)),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
