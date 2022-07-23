import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../shared/cubit/app_cubit.dart';

Widget dictionaryItem({
  required Map model,
  context,
  bool notDismissible = false,
  bool isFlipable = false,
  bool isFavorite = false,
  bool showFavorite = false,
  String? state,
  int? id,
}) {
  bool isclicked = false;
  AppCubit cubit = AppCubit.get(context);
  return AbsorbPointer(
    absorbing: notDismissible,
    child: Dismissible(
      direction: isFlipable == true || isFavorite == true
          ? DismissDirection.none
          : DismissDirection.horizontal,
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: double.infinity,
          height: 110,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/american-flag.png',
                        ),
                        fit: BoxFit.cover,
                        opacity: 0.4,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    width: 150,
                    height: 110,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${model['englishWord']}',
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RobotoSlab',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  showFavorite == true
                      ? Positioned(
                          top: -2,
                          left: -2,
                          child: IconButton(
                            onPressed: () {
                              if (model['status'] == 'notFav') {
                                cubit.favIconButton(
                                    status: 'fav', id: model['id']);
                              } else {
                                cubit.favIconButton(
                                    status: 'notFav', id: model['id']);
                              }
                            },
                            icon: Icon(
                              MdiIcons.heart,
                              color: model['status'] == 'notFav'
                                  ? Colors.white
                                  : Colors.red,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              isFlipable == false
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/arabic2.jpg',
                              ),
                              fit: BoxFit.cover,
                              opacity: 0.4,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          width: 150,
                          height: 110,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${model['arabicWord']}',
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'RobotoSlab',
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : FlipCard(
                      fill: Fill.fillBack,
                      direction: FlipDirection.HORIZONTAL,
                      front: Container(
                        width: 150,
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/questionMark.jpg',
                            ),
                            fit: BoxFit.cover,
                            opacity: 0.7,
                          ),
                        ),
                      ),
                      back: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 150,
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/arabic2.jpg',
                                ),
                                fit: BoxFit.cover,
                                opacity: 0.4,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            width: 150,
                            height: 110,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${model['arabicWord']}',
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'RobotoSlab',
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget defaultTextFormField({
  required String labelText,
  required IconData prefixIcon,
  required TextEditingController controller,
  required TextInputType inputType,
  IconData? suffixIcon,
  bool isPassword = false,
  void Function()? onTap,
  void Function()? suffixIconPressed,
  Function(String)? onChange,
  required String? Function(String?)? validator,
  bool isClickable = true,
  bool autoFocus = false,
}) =>
    TextFormField(
      autofocus: autoFocus,
      keyboardType: inputType,
      obscureText: isPassword,
      validator: validator,
      onTap: onTap,
      onChanged: onChange,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixIconPressed,
                icon: Icon(suffixIcon),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
      controller: controller,
    );

Widget noWords({required String text, bool isFav = false}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isFav == false
              ? MdiIcons.alphabeticalVariantOff
              : MdiIcons.heartBroken,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
}

void navigateTo({context, widget}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
