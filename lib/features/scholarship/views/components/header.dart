import 'package:flutter/material.dart';
import 'header_row1.dart';
import 'header_row2.dart';
import 'header_row3.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        HeaderRow1(),
        HeaderRow2(),
      ],
    );
  }
}

class StickyHeaderRow3 extends StatelessWidget {
  const StickyHeaderRow3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Background color for the sticky row
      child: const HeaderRow3(),
    );
  }
}
