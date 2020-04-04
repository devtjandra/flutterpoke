import 'package:flutter/material.dart';
import 'package:flutterpoke/values.dart';
import 'package:flutter/foundation.dart';

class ArcPage extends StatefulWidget {
  // final HeaderAppearance appearance;
  final List<Widget> children;
  final ValueChanged<double> onClose;

  ArcPage({Key key, this.children, this.onClose}) : super(key: key);

  @override
  _ArcPageState createState() => _ArcPageState();
}

class _ArcPageState extends State<ArcPage> with SingleTickerProviderStateMixin {
  AnimationController max;

  @override
  void initState() {
    super.initState();
    max = AnimationController.unbounded(
        vsync: this, value: maxExtent(HeaderAppearance.arc));
  }

  @override
  void didUpdateWidget(ArcPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (widget.appearance != oldWidget.appearance) {
    //   max.animateTo(
    //     maxExtent(widget.appearance),
    //     duration: AppDurations.arcDuration,
    //     curve: Curves.easeInOut,
    //   );
    // }
  }

  @override
  void dispose() {
    max.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: max,
        child: SliverList(delegate: SliverChildListDelegate(widget.children)),
        builder: (context, child) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                  pinned: true,
                  delegate: AnimatedHeaderDelegate(
                      appearance: HeaderAppearance.arc,
                      minExtent: AppDimens.arcMinHeight,
                      maxExtent: max.value,
                      onClose: widget.onClose)),
              child
            ],
          );
        });
  }
}

class AnimatedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final HeaderAppearance appearance;
  final ValueChanged<double> onClose;

  @override
  final double minExtent;
  @override
  final double maxExtent;

  AnimatedHeaderDelegate(
      {this.appearance, this.minExtent, this.maxExtent, this.onClose});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final shrink = shrinkOffset / (maxExtent - minExtent);
    onClose(shrink);
    return AnimatedHeader(
      appearance: appearance,
      curvature: 1 - shrink,
    );
  }

  @override
  bool shouldRebuild(AnimatedHeaderDelegate oldDelegate) {
    return appearance != oldDelegate.appearance ||
        minExtent != oldDelegate.minExtent ||
        maxExtent != oldDelegate.maxExtent;
  }
}

class AnimatedHeader extends StatefulWidget {
  final double curvature;
  final HeaderAppearance appearance;

  AnimatedHeader({Key key, this.curvature, this.appearance}) : super(key: key);

  @override
  _AnimatedHeaderState createState() => _AnimatedHeaderState();
}

class _AnimatedHeaderState extends State<AnimatedHeader>
    with TickerProviderStateMixin {
  AnimationController _arcAnimation;

  @override
  void initState() {
    super.initState();

    _arcAnimation = AnimationController(
        vsync: this, value: animationValue(widget.appearance));
  }

  @override
  void didUpdateWidget(AnimatedHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.appearance != oldWidget.appearance) {
      _arcAnimation.animateTo(animationValue(widget.appearance),
          duration: AppDurations.arcDuration);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: CurvedAnimation(parent: _arcAnimation, curve: Curves.linear),
        builder: (context, child) {
          return ClipPath(
              clipper:
                  ArcClipper(curvature: _arcAnimation.value * widget.curvature),
              child: child);
        },
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              height: 800,
              decoration: AppStyles.gradientDecor,
            )
          ],
        ));
  }
}

class ArcClipper extends CustomClipper<Path> {
  final double curvature;

  ArcClipper({this.curvature});

  @override
  Path getClip(Size size) {
    if (curvature == 0)
      return Path()..addRect(Offset.zero & size);
    else
      return Path()
        ..moveTo(0.0, 0.0)
        ..lineTo(size.width, 0.0)
        ..lineTo(size.width, size.height - size.height * 0.3 * curvature)
        ..quadraticBezierTo(size.width / 2, size.height, 0.0,
            size.height - size.height * 0.3 * curvature)
        ..close();
  }

  @override
  bool shouldReclip(ArcClipper oldClipper) {
    return curvature != oldClipper.curvature;
  }
}

enum HeaderAppearance { arc, normal }

double maxExtent(HeaderAppearance appearance) {
  return appearance == HeaderAppearance.arc
      ? AppDimens.arcMaxHeight
      : AppDimens.arcMinHeight + 1;
}

double animationValue(HeaderAppearance appearance) {
  return appearance == HeaderAppearance.arc ? 1 : 0;
}
