import 'package:app/presentation/common/jay_colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// inspiration: https://docs.flutter.dev/cookbook/effects/expandable-fab
@immutable
class ExpandableFab extends StatefulWidget {
  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  final ValueNotifier<JayFabEvent> notifier;

  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
    required this.notifier,
  });

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  IconData _iconWhenClosed = Icons.alarm;

  Color _colorWhenClosed = JayColors.red;

  String _textWhenClosed = '';

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );

    widget.notifier.addListener(() {
      switch (widget.notifier.value) {
        case OpenFab():
          _openFab();
          break;
        case CloseFab():
          _closeFab();
          break;
        case CloseWithNewIconFab():
          _iconWhenClosed = (widget.notifier.value as CloseWithNewIconFab).icon;
          _colorWhenClosed = (widget.notifier.value as CloseWithNewIconFab).backgroundColor;
          _textWhenClosed = (widget.notifier.value as CloseWithNewIconFab).text;
          _closeFab();
          break;
        case ToggleFab():
          _toggle();
          break;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _openFab() {
    if (!_open) {
      setState(() {
        _open = true;
        _controller.forward();
      });
    }
  }

  void _closeFab() {
    if (_open) {
      setState(() {
        _open = false;
        _controller.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox.expand(
        child: Stack(
          alignment: Alignment.bottomRight,
          clipBehavior: Clip.none,
          children: [
            _buildTapToCloseFab(),
            ..._buildExpandingActionButtons(),
            _buildTapToOpenFab(),
          ],
        ),
      );

  Widget _buildTapToCloseFab() => const SizedBox.shrink();

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = widget.distance / (count - 1);
    for (var i = 0, distance = 0.0; i < count; i++, distance += step) {
      children.add(
        _ExpandingActionButton(
          directionDistance: distance,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() => IgnorePointer(
        ignoring: _open,
        child: AnimatedContainer(
          transformAlignment: Alignment.center,
          transform: Matrix4.diagonal3Values(
            _open ? 0.7 : 1.0,
            _open ? 0.7 : 1.0,
            1.0,
          ),
          duration: const Duration(milliseconds: 250),
          curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
          child: AnimatedOpacity(
            opacity: _open ? 0.0 : 1.0,
            curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
            duration: const Duration(milliseconds: 250),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _colorWhenClosed,
              ),
              onPressed: _toggle,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_textWhenClosed, style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(width: 10),
                  Icon(_iconWhenClosed, color: JayColors.secondary,size: 28,),
                ],
              ),
            ),
          ),
        ),
      );
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionDistance,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionDistance;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: progress,
        builder: (context, child) {
          final offset = Offset.fromDirection(
            maxDistance,
          );

          return Positioned(
            right: offset.dx + directionDistance + progress.value,
            child: Transform.translate(
              offset: offset,
              child: child!,
            ),
          );
        },
        child: FadeTransition(
          opacity: progress,
          child: child,
        ),
      );
}

sealed class JayFabEvent {
  const JayFabEvent();

  factory JayFabEvent.open() = OpenFab;

  factory JayFabEvent.close() = CloseFab;

  factory JayFabEvent.toggle() = ToggleFab;

  factory JayFabEvent.closeWithNewParams(
    final IconData icon,
    final Color backgroundColor,
    final String text,
  ) = CloseWithNewIconFab;
}

final class OpenFab extends JayFabEvent {}

final class CloseFab extends JayFabEvent {}

final class ToggleFab extends JayFabEvent {}

final class CloseWithNewIconFab extends JayFabEvent with EquatableMixin {
  final IconData icon;

  final Color backgroundColor;

  final String text;

  CloseWithNewIconFab(this.icon, this.backgroundColor, this.text);

  @override
  List<Object?> get props => [icon, backgroundColor, text];

  @override
  bool? get stringify => true;
}
