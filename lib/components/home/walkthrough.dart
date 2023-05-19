import 'package:booqs_mobile/components/home/walkthrough_1.dart';
import 'package:booqs_mobile/components/home/walkthrough_2.dart';
import 'package:booqs_mobile/components/home/walkthrough_3.dart';
import 'package:booqs_mobile/components/home/walkthrough_4.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HomeWalkthrough extends StatefulWidget {
  const HomeWalkthrough({super.key});

  @override
  State<HomeWalkthrough> createState() => _HomeWalkthroughState();
}

class _HomeWalkthroughState extends State<HomeWalkthrough> {
  final _controller = PageController();
  List<Widget> _pages = [];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeWalkthrough1(),
      const HomeWalkthrough2(),
      const HomeWalkthrough3(),
      const HomeWalkthrough4(),
    ];
    _controller.addListener(() {
      int next = _controller.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(0, 1.0 - ((index - _currentPage).abs() * 0.3))
          .toDouble()
          .clamp(0.0, 1.0),
    );

    double zoom = 1.0 + (2.0 - 1.0) * selectedness;

    return SizedBox(
      width: 25.0,
      child: Center(
        child: Material(
          color: index == _currentPage ? Colors.white : Colors.lightGreen,
          type: MaterialType.circle,
          child: SizedBox(
            width: 4.0 * zoom,
            height: 4.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      padding: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 32),
            child: PageView(
              controller: _controller,
              children: _pages,
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(_pages.length, _buildDot),
            ),
          ),
        ],
      ),
    );
  }
}
