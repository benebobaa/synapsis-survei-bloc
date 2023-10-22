// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:synapsis_survei/domain/entities/detail_survei_entity.dart';
import 'package:synapsis_survei/domain/entities/survei_answer_entity.dart';
import 'package:synapsis_survei/presentation/bloc/survei_detail_bloc/detail_survei_bloc.dart';
import 'package:synapsis_survei/presentation/bloc/survei_detail_bloc/detail_survei_event.dart';

class RadioButtonAnswerList extends StatelessWidget {
  RadioButtonAnswerList({
    Key? key,
    required this.data,
    this.valuePicked,
  }) : super(key: key);

  final DetailQuestionsEntity data;
  final ValueNotifier<int?> _groupValue = ValueNotifier<int?>(null);
  final int? valuePicked;

  @override
  Widget build(BuildContext context) {
    _groupValue.value = valuePicked;
    return ValueListenableBuilder(
      valueListenable: _groupValue,
      builder: (context, value, child) => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.options.length,
        itemBuilder: (context, index) => ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          title: Text(data.options[index].optionName),
          leading: Radio(
            value: data.options[index].value,
            groupValue: _groupValue.value,
            onChanged: (value) {
              _groupValue.value = value;
              context.read<DetailSurveiBloc>().add(
                    OnAnswerQuestion(
                      DataSurveiAnswerEntity(
                          questionId: data.options[index].questionId,
                          answer: data.options[index].optionName,
                          value: data.options[index].value),
                    ),
                  );
            },
          ),
        ),
      ),
    );
  }
}
