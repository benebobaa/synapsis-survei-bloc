import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:synapsis_survei/presentation/widgets/custom_elevated_button.dart';

class QuestionNumberPicker extends StatelessWidget {
  const QuestionNumberPicker({super.key});

  static void buildTopSheet(BuildContext context) {
    final CarouselController controller = CarouselController();
    final ValueNotifier<int> indexValue = ValueNotifier<int>(0);

    List<Widget> itemList = [
      GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 5,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          for (int i = 0; i < 20; i++)
            Material(
                child: CustomElevatedButton(
                    title: '50', isOutlined: true, onPressed: () {})),
        ],
      ),
      GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 5,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: [
          for (int i = 0; i < 20; i++)
            Material(
              child: Container(
                color: Colors.blue,
                child: const Text('he'),
              ),
            ),
        ],
      ),
    ];
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 300),
        barrierLabel: MaterialLocalizations.of(context).dialogLabel,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: ((context, animation, secondaryAnimation, child) =>
            SlideTransition(
              position:
                  CurvedAnimation(parent: animation, curve: Curves.easeInCubic)
                      .drive(Tween<Offset>(
                begin: const Offset(0, -1.0),
                end: Offset.zero,
              )),
              child: child,
            )),
        pageBuilder: (context, _, __) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: ValueListenableBuilder(
                  valueListenable: indexValue,
                  builder: (context, value, child) => Column(
                    // shrinkWrap: true,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 30, left: 10),
                        child: Material(
                          child: Text(
                            'Survei Question',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const Row(
                        children: [Expanded(child: Divider())],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CarouselSlider(
                          items: itemList,
                          carouselController: controller,
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.6,
                            autoPlay: false,
                            enlargeCenterPage: true,
                            aspectRatio: 2.0,
                            viewportFraction: 1.0,
                            onPageChanged: (index, reason) {
                              indexValue.value = index;
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: itemList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => controller.animateToPage(entry.key),
                            child: Container(
                              width: 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.blue)
                                      .withOpacity(
                                          indexValue.value == entry.key
                                              ? 0.9
                                              : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) => const SizedBox();
}
