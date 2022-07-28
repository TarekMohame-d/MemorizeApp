import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../shared/cubit/app_cubit.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Map<dynamic, dynamic>> word = [] ;
        for (int i = 0; i < AppCubit.get(context).words.length; i++)
        {
          if(AppCubit.get(context).words[i]['status'] == 'fav')
          {
            word.add(AppCubit.get(context).words[i]);
          }
        }
        return word.isNotEmpty
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => dictionaryItem(
                  model: word[index],
                  context: context,
                  showFavorite: true,
                  isFavorite: true,
                ),
                separatorBuilder: (context, index) => word.length <= 1
                    ? const SizedBox()
                    : const Divider(
                        color: Colors.grey,
                        indent: 20.0,
                        endIndent: 20.0,
                        height: 1.0,
                        thickness: 3,
                      ),
                itemCount: word.length,
              )
            : noWords(text: 'There are no favorite words',num: 2);
      },
    );
  }
}
