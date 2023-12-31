// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survei/core/common/widgets/custom_snackbar.dart';

import 'package:synapsis_survei/domain/entities/detail_survei_entity.dart';
import 'package:synapsis_survei/domain/entities/survei_answer_entity.dart';
import 'package:synapsis_survei/presentation/bloc/survei_detail_bloc/detail_survei_bloc.dart';
import 'package:synapsis_survei/presentation/bloc/survei_detail_bloc/detail_survei_event.dart';
import 'package:synapsis_survei/presentation/pages/survei_page.dart';
import 'package:synapsis_survei/presentation/widgets/custom_elevated_button.dart';
import 'package:synapsis_survei/presentation/widgets/question_number_picker.dart';
import 'package:synapsis_survei/presentation/widgets/radio_button_answer_list.dart';
import 'package:timer_count_down/timer_count_down.dart';

class MainContentQuestion extends StatelessWidget {
  const MainContentQuestion(
      {Key? key,
      required this.data,
      required this.allSurveiData,
      required this.currentQuestion,
      required this.totalQuestion,
      required this.surveiName,
      required this.questionName,
      this.valuePicked,
      required this.dataAnswer})
      : super(key: key);

  final DetailQuestionsEntity data;
  final DataDetailSurveiEntity allSurveiData;
  final SurveiAnswerEntity dataAnswer;
  final int currentQuestion;
  final int totalQuestion;
  final String surveiName;
  final String questionName;
  final int? valuePicked;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Countdown(
                      //TODO: YOU CAN CHANGE THE COUNTDOWN TIME HERE #BENE
                      seconds: 60,
                      build: (_, double time) {
                        return Expanded(
                          flex: 2,
                          child: CustomElevatedButton(
                            title: '${time.toInt()} Seconds Left',
                            isOutlined: true,
                            onPressed: () {},
                            height: MediaQuery.of(context).size.height * 0.074,
                          ),
                        );
                      },
                      onFinished: () {
                        context.read<DetailSurveiBloc>().add(OnSubmitSurvei());
                        CustomSnackbar.showMessage(
                            'Terimakasih telah mengisi survei', context);
                        Navigator.popUntil(
                            context, ModalRoute.withName(SurveiPage.routeName));
                      },
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                    Expanded(
                        child: CustomElevatedButton(
                      currentQuestion: currentQuestion + 1,
                      totalQuestion: totalQuestion,
                      icon: Icons.list_alt_outlined,
                      title: 'Question Number',
                      isOutlined: false,
                      height: MediaQuery.of(context).size.height * 0.074,
                      onPressed: () {
                        QuestionNumberPicker.buildTopSheet(context,
                            allSurveiData, dataAnswer, currentQuestion);
                      },
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  surveiName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  '${currentQuestion + 1}. $questionName',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 10,
                      color: Color(0xFFEEF6F9),
                    ),
                  ),
                ],
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text('Answer')),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.3,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          RadioButtonAnswerList(data: data, valuePicked: valuePicked),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
