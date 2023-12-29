import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged? onClickFilter;

  const SearchBarWidget({key, this.onClickFilter}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Theme.of(context).focusColor.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 12, start: 0),
              child: Icon(Icons.search_outlined, color: Theme.of(context).colorScheme.secondary),
            ),
            TextField(
              
            )
          ],
        ),
      ),
    );
  }
}