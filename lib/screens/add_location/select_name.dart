import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:svitlo/data_cubit/data_cubit.dart';
import 'package:svitlo/group_cubit/group_cubit.dart';
import 'package:svitlo/main_screen_cubit/main_screen_cubit.dart';
import 'package:svitlo/models/icon_model.dart';
import 'package:svitlo/repository/group_repository.dart';
import 'package:svitlo/repository/location_repository.dart';
import 'package:svitlo/screens/main_screen.dart';

import '../../ui_kit/text_style.dart';

List iconsButtons = ['home', 'gym', 'work', 'car'];

class SelectName extends StatelessWidget {
  String groupId;

  SelectName({Key? key, required this.groupId}) : super(key: key);

  // final DataCubit cubit = DataCubit(repository: LocationRepository());
  // final MainScreenCubit cubit = MainScreenCubit(LocationRepository());
  final GroupCubit cubit = GroupCubit(LocationRepository());
  final TextEditingController formController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Група $groupId",
          style: p,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: BlocProvider(
          create: (_) => GroupCubit(LocationRepository()),
          child: BlocBuilder<GroupCubit, GroupCubitState>(
            builder: (context, state) {
              bool isButtonEnabled = formController.text.length >= 3 && state.icons.any((icon) => icon.selected == true);

              return Column(
                children: [
                  TextFormField(
                    style: p,
                    decoration: const InputDecoration(
                      hintText: 'Мій дім',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    controller: formController,
                  ),
                  const Gap(15.0),
                  _buildIcons(),
                  ElevatedButton(

                    onPressed: () {
                      String _searchSelected() {
                        String name = '';
                        for (var element in state.icons) {
                          if (element.selected == true) {
                            name = element.iconName.toString();
                          }
                        }

                        return name;
                      }

                      final iconName = _searchSelected();

                      cubit.addLocation(formController.text, int.parse(groupId), iconName);
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: const Text('Submit'),
                    style: formController.text.length < 3 ? ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                      Colors.white12)) : ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                      Colors.yellow)
                    )
                  ),
                  // StreamB
                ],
              );

            },
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildIcons() {
    return StreamBuilder<List<IconModel>>(
      stream: cubit.stream.map((state) => state.icons),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final icons = snapshot.data!;
          return Container(
            width: double.infinity,
            height: 150.0,
            child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              children: List.generate(
                icons.length,
                    (index) {
                  final iconModel = icons[index];
                  return GestureDetector(
                    onTap: () {
                      cubit.refreshIcon(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: iconModel.selected! ? Colors.orangeAccent : Colors.white12,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Icon(
                          iconModel.iconData,
                          size: 50.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

}