import 'dart:async';
import 'package:demo/page1.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MaterialApp(title: "List View", home: HomePage()));
}

List<String> text = [
  "Alarm",
  "Account",
  "Shopping",
  "Camera",
  "Food",
  "Fast Forward",
  "Menu",
  "Loyality"
];
List<Color> colors = [
  Colors.cyan,
  Colors.amberAccent,
  Colors.pinkAccent,
  Colors.limeAccent,
  Colors.blueAccent,
  Colors.deepPurpleAccent,
  Colors.redAccent,
  Colors.cyanAccent,
];
List<IconData> icons = [
  Icons.access_alarm,
  Icons.account_balance_wallet,
  Icons.add_shopping_cart,
  Icons.camera,
  Icons.fastfood,
  Icons.fast_forward,
  Icons.menu,
  Icons.loyalty,
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Home"),
        backgroundColor: Colors.teal,
      ),
      drawer: Example(),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            "Hi people!!",
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => new _ExampleState();
}

class _ExampleState extends State<Example> with TickerProviderStateMixin {
  AnimationController _animationController;
  double animationDuration = 0.0;
  int totalItems = 8;

  @override
  void initState() {
    super.initState();
    final int totalDuration = 2000;
    _animationController = AnimationController(
        vsync: this, duration: new Duration(milliseconds: totalDuration));
    animationDuration = totalDuration / (100 * (totalDuration / (totalItems)));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: totalItems,
        itemBuilder: (BuildContext context, int index) {
          return new Item(
              index: index,
              animationController: _animationController,
              duration: animationDuration,
              color: colors[index],
              icon: icons[index],
              text: text[index]);
        },
      ),
    );
  }
}

class Item extends StatefulWidget {
  final int index;
  final AnimationController animationController;
  final double duration;
  final Color color;
  final IconData icon;
  final String text;
  Item(
      {this.index,
      this.animationController,
      this.duration,
      this.color,
      this.icon,
      this.text});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  Animation _animation;
  double start;
  double end;
  Animation<double> rotateY;

  @override
  void initState() {
    super.initState();
    start = (widget.duration * widget.index).toDouble();
    end = start + widget.duration;

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          widget.index == 0 ? start : start - widget.duration / 2,
          widget.index == 0 ? end + widget.duration : end + widget.duration / 2,
          curve: Curves.easeIn,
        ),
      ),
    )..addListener(() {
        setState(() {});
      });

    rotateY = new Tween<double>(
      begin: -0.5,
      end: .0,
    ).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(
          widget.index == 0 ? start : start - widget.duration / 2,
          widget.index == 0 ? end + widget.duration : end + widget.duration / 2,
          curve: Curves.easeIn,
        ),
      ),
    );
  }

  Future<Null> reverse() async {
    await widget.animationController.reverse().orCancel;
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Page(
                color: widget.color,
                icon: widget.icon,
                text: widget.text,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        final card = Opacity(
            opacity: _animation.value,
            child: InkWell(
                onTap: () {
                  reverse();
                },
                child: new Container(
                  width: 200,
                  height: 400,
                  color: widget.color,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        widget.icon,
                        size: 55,
                        color: Colors.black,
                      ),
                      Text(widget.text)
                    ],
                  ),
                )));

        return new Transform(
          transform: new Matrix4.rotationY(rotateY.value * math.pi),
          alignment: Alignment.centerLeft,
          child: card,
        );
      },
    );
  }
}
