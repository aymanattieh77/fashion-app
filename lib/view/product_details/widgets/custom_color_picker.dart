import 'package:fashion_app/core/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomColorPicker extends StatelessWidget {
  const CustomColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleColorRow(
      colors: [
        AppColor.lightBlue,
        AppColor.lightgreen,
        AppColor.orangeLight,
        AppColor.yallowLight
      ],
    );
  }
}

class CircleColorRow extends StatefulWidget {
  const CircleColorRow({
    super.key,
    required this.colors,
  });
  final List<Color> colors;
  @override
  State<CircleColorRow> createState() => _CircleColorRowState();
}

class _CircleColorRowState extends State<CircleColorRow> {
  int currentTab = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        widget.colors.length,
        (index) {
          return InkWell(
            onTap: () {
              setState(() {
                currentTab = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(2.0),
              width: 26,
              height: 26,
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: currentTab == index
                    ? Border.all(color: AppColor.orange, width: 1.5)
                    : null,
              ),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.colors[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
