
import '../../shared/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';

class RandomWordScreen extends StatelessWidget {
  const RandomWordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        
        var word = AppCubit.get(context).shuffledWords;
        
        return word.isNotEmpty ? ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              dictionaryItem(model: word[index], context: context,notDismissible: true),
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
        ): noWords(text: 'No words Yet, PLease Add Some Words');
      },
    );
  }
}
