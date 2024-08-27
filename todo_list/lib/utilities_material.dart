import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Utilities extends StatelessWidget {
  const Utilities(
      {super.key,
      required this.taskname,
      required this.taskdone,
      this.onChanged,
      required this.onDelete});
  final String taskname;
  final bool taskdone;
  final Function(bool?)? onChanged;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.deepPurple.shade400,
            borderRadius: BorderRadius.circular(20.0)),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
              value: taskdone,
              onChanged: onChanged,
              checkColor: Colors.black,
              activeColor: Colors.white,
              side: const BorderSide(color: Colors.white),
            ),
            Text(
              taskname,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  decoration: taskdone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationThickness: 3,
                  decorationColor: Colors.deepPurple.shade700),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: onDelete,
                child:const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}
