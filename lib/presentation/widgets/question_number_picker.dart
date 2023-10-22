import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survei/domain/entities/detail_survei_entity.dart';
import 'package:synapsis_survei/domain/entities/survei_answer_entity.dart';
import 'package:synapsis_survei/presentation/bloc/survei_detail_bloc/detail_survei_bloc.dart';
import 'package:synapsis_survei/presentation/bloc/survei_detail_bloc/detail_survei_event.dart';
import 'package:synapsis_survei/presentation/widgets/custom_elevated_button.dart';

class QuestionNumberPicker extends StatelessWidget {
  const QuestionNumberPicker({super.key});

  static void buildTopSheet(BuildContext context, DataDetailSurveiEntity data,
      SurveiAnswerEntity dataAnswer, int currentQuestion) {
    final CarouselController controller = CarouselController();
    final ValueNotifier<int> indexValue = ValueNotifier<int>(0);
    bool isFound = false;

    List<List<DetailQuestionsEntity>> newList = [];

    for (int i = 0; i < data.questions.length; i += 20) {
      if (i + 20 <= data.questions.length) {
        newList.add(data.questions.sublist(i, i + 20));
      } else {
        newList.add(data.questions.sublist(i));
      }
    }

    for (int i = 0; i < newList.length; i++) {
      for (var i in newList[i]) {
        if (i.questionNumber == currentQuestion + 1) {
          isFound = true;
          break;
        }
      }
      if (isFound) {
        indexValue.value = i;
        break;
      }
      isFound = false;
    }

    List<Widget> itemList = [
      for (var subList in newList)
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 5,
          childAspectRatio: 1.0,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            for (var i in subList)
              Material(
                child: (i.questionNumber - 1 == currentQuestion)
                    ? CustomElevatedButton(
                        currentPosition: true,
                        title: '${i.questionNumber}',
                        isOutlined: true,
                        onPressed: () {},
                      )
                    : (dataAnswer.data.length > i.questionNumber - 1 &&
                            dataAnswer.data[i.questionNumber - 1].answer != '')
                        ? CustomElevatedButton(
                            title: '${i.questionNumber}',
                            isOutlined: false,
                            onPressed: () {
                              context.read<DetailSurveiBloc>().add(
                                  OnSelectFromPicker(i.questionNumber - 1));
                              Navigator.pop(context);
                            },
                          )
                        : CustomElevatedButton(
                            title: '${i.questionNumber}',
                            isOutlined: true,
                            onPressed: () {
                              context.read<DetailSurveiBloc>().add(
                                  OnSelectFromPicker(i.questionNumber - 1));
                              Navigator.pop(context);
                            },
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
                            initialPage: indexValue.value,
                            height: MediaQuery.of(context).size.height * 0.52,
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
                                      .withOpacity(indexValue.value == entry.key
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
