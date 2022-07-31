import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../../shared/cubit/app_cubit.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        var searchWords = AppCubit.get(context).searchResults;
        var word = AppCubit.get(context).words;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    end: 20.0, start: 20.0, top: 5),
                child: defaultTextFormField(
                  autoFocus: true,
                  controller: searchController,
                  inputType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Search must not be empty';
                    }
                    return null;
                  },
                  prefixIcon: Icons.search,
                  labelText: 'Search',
                  onChange: (value) {
                    cubit.runFilter(value);
                  },
                ),
              ),
              searchWords.isNotEmpty
                  ? Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => dictionaryItem(
                          model: searchWords[index],
                          context: context,
                          notDismissible: true,
                        ),
                        separatorBuilder: (context, index) =>
                            searchWords.length <= 1
                                ? const SizedBox()
                                : const Divider(
                                    color: Colors.grey,
                                    indent: 20.0,
                                    endIndent: 20.0,
                                    height: 1.0,
                                    thickness: 3,
                                  ),
                        itemCount: searchWords.length,
                      ),
                    )
                  : word.isNotEmpty
                      ? searchController.text.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 100.0),
                              child: Center(
                                  child: CircularProgressIndicator()),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: noWords(
                                  text: 'There is no word for this', num: 3),
                            )
                      : Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: noWords(
                              text: 'No words Yet, PLease Add Some Words',
                              num: 1),
                        ),
            ],
          ),
        );
      },
    );
  }
}
