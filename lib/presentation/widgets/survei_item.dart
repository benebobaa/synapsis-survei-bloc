// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:synapsis_survei/core/constants/media_res.dart';
import 'package:synapsis_survei/core/helpers/date_parser.dart';
import 'package:synapsis_survei/presentation/pages/detail_survei_page.dart';

class SurveiItem extends StatelessWidget {
  const SurveiItem({
    Key? key,
    required this.surveiName,
    required this.surveiCreatedAt,
    required this.surveiId,
  }) : super(key: key);

  final String surveiName;
  final String surveiCreatedAt;
  final String surveiId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailSurveiPage.routeName,
          arguments: surveiId,
        );
      },
      child: Card(
        elevation: 0.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // if you need this
          side: BorderSide(
            color: Colors.grey.withOpacity(0.6),
            width: 1,
          ),
        ),
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(MediaRes.imgSurvei),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(surveiName),
            subtitle: Text(
              DateParser.readAbleDate(surveiCreatedAt),
              style: const TextStyle(color: Colors.green),
            ),
          ),
        ),
      ),
    );
  }
}
