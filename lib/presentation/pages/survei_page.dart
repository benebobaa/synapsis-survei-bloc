import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survei/core/common/widgets/custom_snackbar.dart';
import 'package:synapsis_survei/presentation/bloc/survei_bloc/survei_bloc.dart';
import 'package:synapsis_survei/presentation/bloc/survei_bloc/survei_event.dart';
import 'package:synapsis_survei/presentation/bloc/survei_bloc/survei_state.dart';
import 'package:synapsis_survei/presentation/pages/login_page.dart';
import 'package:synapsis_survei/presentation/widgets/survei_item.dart';

class SurveiPage extends StatefulWidget {
  const SurveiPage({super.key});

  static const routeName = '/';

  @override
  State<SurveiPage> createState() => _SurveiPageState();
}

class _SurveiPageState extends State<SurveiPage> {
  @override
  void initState() {
    context.read<SurveiBloc>().add(const OnCheckCookie());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          context.read<SurveiBloc>().add(const OnDeleteCookie()); //logout
        },
        child: const Icon(
          Icons.logout,
          color: Colors.blue,
        ),
      ),
      appBar: AppBar(
        title: const Text('Halaman Survei'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Center(
            child: BlocConsumer<SurveiBloc, SurveiState>(
          listener: (context, state) {
            if (state is SurveiLoadFailure) {
              CustomSnackbar.showMessage(state.message, context);
            }
            if (state is GetCookie) {
              if (state.cookie == '') {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginPage.routeName, (route) => false);
              } else {
                context.read<SurveiBloc>().add(const OnGetAllSurvei());
              }
            }

            if (state is CookieDeleted) {
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginPage.routeName, (route) => false);
            }
          },
          builder: (context, state) {
            if (state is SurveiLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SurveiEmpty) {
              return const Center(
                child: Text('Tidak ada survei'),
              );
            }
            if (state is SurveiLoaded) {
              return ListView.builder(
                itemCount: state.result.data.length,
                itemBuilder: (context, index) {
                  return SurveiItem(
                    surveiName: state.result.data[index].surveyName,
                    surveiCreatedAt: state.result.data[index].createdAt,
                    surveiId: state.result.data[index].id,
                  );
                },
              );
            }
            return const SizedBox();

          },
        )),
      ),
    );
  }
}
