import 'package:fashion_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

class BackToTopButton extends StatefulWidget {
  const BackToTopButton({super.key, required this.scrollController});

  final ScrollController scrollController;
  @override
  State<BackToTopButton> createState() => _BackToTopButtonState();
}

class _BackToTopButtonState extends State<BackToTopButton> {
  bool showBtn = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_listener);
  }

  _listener() {
    double showoffset = 15.0;
    if (widget.scrollController.offset > showoffset) {
      showBtn = true;
      setState(() {});
    } else {
      showBtn = false;
      setState(() {});
    }
  }

  _backToTop() {
    //go to top of scroll
    widget.scrollController.animateTo(0, //scroll offset to go
        duration: const Duration(milliseconds: 500), //duration of scroll
        curve: Curves.fastOutSlowIn //scroll type
        );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500), //show/hide animation
      opacity: showBtn ? 1.0 : 0.0, //set obacity to 1 on visible, or hide
      child: FloatingActionButton(
        onPressed: _backToTop,
        backgroundColor: AppColor.orange,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
