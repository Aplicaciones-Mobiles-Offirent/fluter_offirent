import 'package:flutter/material.dart';


class BackdropWidget extends StatefulWidget {

  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;


  const BackdropWidget({Key? key,
    required this.frontLayer,
    required this.backLayer,
    required this.frontTitle,
    required this.backTitle})
      : super(key: key);

  @override
  _BackdropWidgetState createState() => _BackdropWidgetState();
}

class _BackdropWidgetState extends State<BackdropWidget> with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      value: 1.0,
      duration: Duration(milliseconds: 250),
      vsync: this,
    );

    _controller.addStatusListener((status) {
      setState(() {});
    });
  }


  @override
  void dispose() {
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isFrontLayerVisible ? widget.frontTitle: widget.backTitle,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                _toggleLayer();
                },
              icon: Icon(Icons.tune)
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
              const titleHeight = 48;
              final Size canvasSize = constrains.biggest;
              final doubleHeight = canvasSize.height - titleHeight;

              Animation<RelativeRect> layerAnimation = RelativeRectTween(
              begin: RelativeRect.fromLTRB(0, doubleHeight, 0, doubleHeight-canvasSize.height),
              end: RelativeRect.fromLTRB(0, 0, 0, 0),
              ).animate(_controller.view);

            return Stack(
              children: [
                widget.backLayer,
                PositionedTransition(
                    rect: layerAnimation,
                    child: _FrontLayer(child: widget.frontLayer))
              ],
            );

       },
      )
    );
  }

  bool get isFrontLayerVisible {
      final AnimationStatus status = _controller.status;
      return status == AnimationStatus.completed || status == AnimationStatus.forward;
    }


    _toggleLayer() {
      _controller.fling(velocity: isFrontLayerVisible ? -2 : 2);
    }
}



class _FrontLayer extends StatelessWidget {

  final Widget child;

  const _FrontLayer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation:  12.0,
      child: Column(
        children: [
          Expanded(child: child)
        ],
      ),
    );
  }
}
