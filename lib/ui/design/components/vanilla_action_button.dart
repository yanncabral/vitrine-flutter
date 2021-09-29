import 'package:flutter/material.dart';

class VanillaActionButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final Brightness colorScheme;

  const VanillaActionButton({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.colorScheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: MaterialButton(
        height: 60,
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 32, right: 16),
          trailing: CircleAvatar(
            backgroundColor: const Color(0xff9191A6).withOpacity(0.1),
            child: const Icon(
              Icons.chevron_right,
              color: Colors.black,
            ),
          ),
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
