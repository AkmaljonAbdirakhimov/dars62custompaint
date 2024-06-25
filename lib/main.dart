import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ui.Image? image;

  @override
  void initState() {
    super.initState();

    loadImage().then((_) {
      setState(() {});
    });
  }

  Future<void> loadImage() async {
    final ByteData byteData = await rootBundle.load("assets/image.png");
    Uint8List uint8list = byteData.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(uint8list);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    image = frameInfo.image;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Container(
            width: double.infinity,
            height: 800,
            color: Colors.white,
            child: CustomPaint(
              size: const Size(
                double.infinity,
                800,
              ),
              painter: MyPainter(image),
              child: Text("Salom Boyvachcha"),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final ui.Image? image;

  MyPainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    //Todo - Bu yerda sizning reklamangiz bo'lishi kerak edi!
    //? Bu yerda chizmalarni chizamiz

    //! Qorbobo bola yasaymiz!
    final paint = Paint();
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke; // Ichi bo'sh
    paint.strokeWidth = 5;

    final centerFirst = Offset(size.width / 2, size.height / 2 - 150);
    final centerSecond = Offset(size.width / 2, size.height / 2 - 10);
    final centerThird = Offset(size.width / 2, size.height / 2 + 170);
    // Birinchi dumaloqlari / tanasi
    canvas.drawCircle(centerFirst, 60, paint);
    canvas.drawCircle(centerSecond, 80, paint);
    canvas.drawCircle(centerThird, 100, paint);

    // Shlyapasini chizamiz
    final paintShlyapa = Paint();
    paintShlyapa.color = const Color.fromARGB(255, 183, 219, 248);
    paintShlyapa.style = PaintingStyle.fill;

    RRect rectShlayapa = RRect.fromLTRBR(
      size.width / 2 - 50,
      80,
      size.width / 2 + 50,
      200,
      const Radius.circular(20),
    );
    canvas.drawRRect(rectShlayapa, paintShlyapa);

    final paintShlyapaBorder = Paint();
    paintShlyapaBorder.color = Colors.blue;
    paintShlyapaBorder.style = PaintingStyle.stroke;
    paintShlyapaBorder.strokeWidth = 5;

    RRect rectShlayapaBorder = RRect.fromLTRBR(
      size.width / 2 - 50,
      80,
      size.width / 2 + 50,
      200,
      const Radius.circular(20),
    );
    canvas.drawRRect(rectShlayapaBorder, paintShlyapaBorder);

    // Qullari
    final paintHands = Paint();
    paintHands.color = Colors.blue;
    paintHands.style = PaintingStyle.stroke;
    paintHands.strokeWidth = 5;

    final pathHand1 = Path();
    pathHand1.moveTo(size.width / 2 - 75, size.height / 2 - 40);
    pathHand1.lineTo(40, size.height / 2 + 20);
    pathHand1.lineTo(10, size.height / 2 + 20);
    pathHand1.moveTo(40, size.height / 2 + 20);
    pathHand1.lineTo(10, size.height / 2 + 40);
    pathHand1.moveTo(40, size.height / 2 + 20);
    pathHand1.lineTo(30, size.height / 2 + 50);

    pathHand1.close();

    canvas.drawPath(pathHand1, paintHands);

    //? uchburchak
    // final pathTriangle = Path();
    // pathTriangle.moveTo(size.width / 2, size.height / 2);
    // pathTriangle.lineTo(size.width / 2 + 20, size.height / 2 + 50);
    // pathTriangle.lineTo(size.width / 2 - 20, size.height / 2 + 50);

    // pathTriangle.close();
    // canvas.drawPath(pathTriangle, paintHands);

    //? Oyoqlari
    final paintLegs = Paint();
    paintLegs.color = Colors.blue;
    paintLegs.style = PaintingStyle.stroke;
    paintLegs.strokeWidth = 5;

    final rectLeg1 = Rect.fromLTWH(
      size.width / 2 - 50,
      size.height - 130,
      40,
      20,
    );
    canvas.drawOval(rectLeg1, paintLegs);

    final rectLeg2 = Rect.fromLTWH(
      size.width / 2 + 10,
      size.height - 130,
      40,
      20,
    );
    canvas.drawOval(rectLeg2, paintLegs);

    //? Og'zini chizamiz
    final paintMouth = Paint();
    paintMouth.color = Colors.blue;
    paintMouth.style = PaintingStyle.stroke;
    paintMouth.strokeWidth = 5;
    paintMouth.strokeCap = StrokeCap.round;

    final rectMouth = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2 - 130),
      width: 45,
      height: 45,
    );
    canvas.drawArc(
      rectMouth,
      pi / 1.2,
      -pi / 1.5,
      false,
      paintMouth,
    );

    //? Qorbobo ismi
    final nameText = TextPainter(
      text: const TextSpan(
        text: "John!",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    nameText.layout(minWidth: 0, maxWidth: size.width);
    nameText.paint(
      canvas,
      Offset(size.width / 2 - 30, size.height / 2 + 10),
    );

    if (image != null) {
      paintImage(
        canvas: canvas,
        rect: Rect.fromCenter(
          center: Offset(size.width / 2, 140),
          width: 60,
          height: 100,
        ),
        image: image!,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return oldDelegate.image != image;
  }
}
