import '../screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../components/components.dart';
import '../shared/cubit/app_cubit.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout();
  var enController = TextEditingController();
  var arController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(cubit.titles[cubit.currentIndex]),
              actions: [
                cubit.currentIndex == 0
                    ? IconButton(
                        onPressed: () {
                          cubit.searchResults = [];
                          navigateTo(
                            context: context,
                            widget: SearchScreen(),
                          );
                        },
                        icon: const Icon(Icons.search),
                      )
                    : const SizedBox(),
                cubit.currentIndex == 0
                    ? IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(24.0),
                                      ),
                                    ),
                                    scrollable: true,
                                    title: const Text('Word data'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            Navigator.pop(context);
                                            cubit.insertToDatabase(
                                                eWord: enController.text,
                                                aWord: arController.text);
                                            enController =
                                                TextEditingController();
                                            arController =
                                                TextEditingController();
                                          }
                                          if (cubit.alreadyExists == true) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(16.0),
                                                  ),
                                                ),
                                                scrollable: true,
                                                title:
                                                    const Text('Invalid input'),
                                                content: const Text(
                                                  'The word you entered is already exists',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .deepOrange),
                                                    ),
                                                    child: const Text(
                                                      'CLOSE',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.green),
                                        ),
                                        child: const Text(
                                          'SUBMIT',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red),
                                        ),
                                        child: const Text(
                                          'CLOSE',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Form(
                                        key: formKey,
                                        child: Column(
                                          children: [
                                            defaultTextFormField(
                                              autoFocus: true,
                                              controller: enController,
                                              inputType: TextInputType.text,
                                              labelText: 'English word',
                                              validator: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'This field must not be empty';
                                                }
                                                return null;
                                              },
                                              prefixIcon:
                                                  MdiIcons.alphabeticalVariant,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            defaultTextFormField(
                                              controller: arController,
                                              inputType: TextInputType.text,
                                              labelText: 'Arabic word',
                                              validator: (String? value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'This field must not be empty';
                                                }
                                                return null;
                                              },
                                              prefixIcon: MdiIcons.abjadArabic,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                        },
                        icon: const Icon(Icons.add_box),
                      )
                    : const SizedBox(),
                cubit.currentIndex == 1
                    ? IconButton(
                        onPressed: () {
                          if (cubit.words.isNotEmpty) {
                            cubit.shuffle();
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                ),
                                scrollable: true,
                                title: const Text('No Data!'),
                                content: const Text(
                                  'There are no words in your dictionary! Add some to display them here.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.deepOrange),
                                    ),
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        icon: const Icon(MdiIcons.reload),
                      )
                    : const SizedBox(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(MdiIcons.alphabeticalVariant),
                  label: 'Dictionary',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.help),
                  label: 'Random',
                ),
                BottomNavigationBarItem(
                  icon: Icon(MdiIcons.alertBox),
                  label: 'Test',
                ),
                BottomNavigationBarItem(
                  icon: Icon(MdiIcons.heart),
                  label: 'Favorite',
                ),
              ],
            ),
            body: (state is AppGetDatabaseLoadingState)
                ? const Center(child: CircularProgressIndicator())
                : cubit.screens[cubit.currentIndex],
          );
        },
      );
  }
}
