import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

class SearchCustom extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  SearchCustom({required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return AnimSearchBar(
      width: 250,
      textController: controller,
      prefixIcon: Icon(Icons.search, color: Colors.black),
      suffixIcon: Icon(Icons.search, color: Colors.black),
      helpText: 'Search any city!',
      onSubmitted: onSearch,
      onSuffixTap: () {
        onSearch(controller.text);
      },
    );
  }
}
