import 'package:flutter/material.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';

class VanillaActionButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final bool enabled;
  final Brightness colorScheme;

  const VanillaActionButton({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.colorScheme,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: enabled ? 1 : 0.4,
      child: Container(
        width: 180,
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: colorScheme == Brightness.light
              ? Colors.white
              : VanillaColorScheme.dark,
        ),
        child: content(context),
      ),
    );
  }

  MaterialButton content(BuildContext context) {
    return MaterialButton(
      height: 60,
      padding: EdgeInsets.zero,
      onPressed: enabled ? onPressed : null,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 32, right: 16),
        trailing: CircleAvatar(
          backgroundColor: const Color(0xff9191A6).withOpacity(0.1),
          child: Icon(
            Icons.chevron_right,
            color:
                colorScheme == Brightness.light ? Colors.black : Colors.white,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme == Brightness.light
                  ? Colors.black
                  : Colors.white),
        ),
      ),
    );
  }
}
