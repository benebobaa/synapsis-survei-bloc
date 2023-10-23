// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survei/core/common/widgets/custom_snackbar.dart';
import 'package:synapsis_survei/presentation/bloc/survei_detail_bloc/detail_survei_bloc.dart';
import 'package:synapsis_survei/presentation/bloc/survei_detail_bloc/detail_survei_event.dart';
import 'package:synapsis_survei/presentation/bloc/survei_detail_bloc/detail_survei_state.dart';
import 'package:synapsis_survei/presentation/widgets/custom_elevated_button.dart';
import 'package:synapsis_survei/presentation/widgets/main_content_question.dart';

class DetailSurveiPage extends StatefulWidget {
  const DetailSurveiPage({
    Key? key,
    required this.surveiId,
  }) : super(key: key);

  static const routeName = '/survei-answer';
  final String surveiId;

  @override
  State<DetailSurveiPage> createState() => _DetailSurveiPageState();
}

class _DetailSurveiPageState extends State<DetailSurveiPage> {
  @override
  void initState() {
    context.read<DetailSurveiBloc>().add(OnGetDetailSurvei(widget.surveiId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showAdaptiveDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to go back?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<DetailSurveiBloc>().add(OnSubmitSurvei());
                    Navigator.pop(context, true);
                  },
                  child: const Text('If you go back, your answer will lost'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<DetailSurveiBloc, DetailSurveiState>(
              listener: (context, state) {
            if (state is DetailSurveiInitial) {}
            if (state is DetailSurveiLoaded) {
              log('state is ${state.surveiAnswerEntity}');
            }
          }, builder: (emit, state) {
            if (state is DetailSurveiLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is DetailSurveiLoadFailure) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is DetailSurveiLoaded) {
              return Stack(
                children: [
                  MainContentQuestion(
                    data: state.result.data.questions[state.index],
                    allSurveiData: state.result.data,
                    currentQuestion: state.index,
                    totalQuestion: state.result.data.questions.length,
                    surveiName: state.result.data.surveyName,
                    questionName:
                        state.result.data.questions[state.index].questionName,
                    valuePicked:
                        state.surveiAnswerEntity.data[state.index].value,
                    dataAnswer: state.surveiAnswerEntity,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              onPressed: () {
                                if (state.index == 0) {
                                  // Navigator.pop(context);
                                } else {
                                  context
                                      .read<DetailSurveiBloc>()
                                      .add(OnBackQuestion());
                                }
                              },
                              isOutlined: true,
                              title: 'Back',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomElevatedButton(
                              onPressed: () {
                                if (state.index ==
                                    state.result.data.questions.length - 1) {
                                  showAdaptiveDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Submit'),
                                      content: const Text(
                                          'Are you sure to submit this answer?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel')),
                                        TextButton(
                                            onPressed: () {
                                              context
                                                  .read<DetailSurveiBloc>()
                                                  .add(OnSubmitSurvei());
                                              CustomSnackbar.showMessage(
                                                  'Terimakasih telah mengisi survei',
                                                  context);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Submit')),
                                      ],
                                    ),
                                  );
                                } else {
                                  context
                                      .read<DetailSurveiBloc>()
                                      .add(OnNextQuestion());
                                }
                              },
                              isOutlined: false,
                              title: state.index ==
                                      state.result.data.questions.length - 1
                                  ? 'Submit'
                                  : 'Next',
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            return const SizedBox();
          }),
        ),
      ),
    );
  }
}
