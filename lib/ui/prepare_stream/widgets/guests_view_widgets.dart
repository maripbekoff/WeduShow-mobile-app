import 'dart:math';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class GuestViewWidgets {
  static const double _thickness = 0.5;

  Widget buildFloatingActionButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          type: MaterialType.transparency,
          child: Ink(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.redAccent, width: 4.0),
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(1000.0),
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(25.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTwoPeopleView(
    BuildContext context,
    CameraController controller,
  ) {
    Size size = MediaQuery.of(context).size;
    double adjustConstant = max(
        size.width /
            min(controller.value.previewSize.width,
                controller.value.previewSize.height),
        size.height /
            max(controller.value.previewSize.width,
                controller.value.previewSize.height));
    double logicalHeight = max(controller.value.previewSize.width,
            controller.value.previewSize.height) *
        adjustConstant;
    double logicalWidth = min(controller.value.previewSize.width,
            controller.value.previewSize.height) *
        adjustConstant;

    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('assets/person.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: ExactAssetImage('assets/person.jpg'),
                      radius: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Барак Обама",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "ЗАЖМИТЕ ЧТОБЫ УДАЛИТЬ ГОСТЯ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.white,
          height: _thickness,
        ),
        Expanded(
          child: ClipRect(
            child: OverflowBox(
              minHeight: 0.0,
              minWidth: 0.0,
              maxHeight: logicalHeight,
              maxWidth: logicalWidth,
              child: SizedBox(
                width: logicalWidth,
                height: logicalHeight,
                child: CameraPreview(controller),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildThreePeopleView(
      BuildContext context, CameraController controller) {
    Size size = MediaQuery.of(context).size;
    double adjustConstant = max(
        size.width /
            min(controller.value.previewSize.width,
                controller.value.previewSize.height),
        size.height /
            max(controller.value.previewSize.width,
                controller.value.previewSize.height));
    double logicalHeight = max(controller.value.previewSize.width,
            controller.value.previewSize.height) *
        adjustConstant;
    double logicalWidth = min(controller.value.previewSize.width,
            controller.value.previewSize.height) *
        adjustConstant;

    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/person.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage:
                                ExactAssetImage('assets/person.jpg'),
                            radius: 50,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Барак Обама",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "ЗАЖМИТЕ ЧТОБЫ УДАЛИТЬ ГОСТЯ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                color: Colors.white,
                width: _thickness,
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/person.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage:
                                ExactAssetImage('assets/person.jpg'),
                            radius: 50,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Барак Обама",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "ЗАЖМИТЕ ЧТОБЫ УДАЛИТЬ ГОСТЯ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.white,
          height: _thickness,
        ),
        Expanded(
          child: ClipRect(
            child: OverflowBox(
              minHeight: 0.0,
              minWidth: 0.0,
              maxHeight: logicalHeight,
              maxWidth: logicalWidth,
              child: SizedBox(
                width: logicalWidth,
                height: logicalHeight,
                child: CameraPreview(controller),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFourPeopleView(
      BuildContext context, CameraController controller) {
    Size size = MediaQuery.of(context).size;
    double adjustConstant = max(
        size.width /
            min(controller.value.previewSize.width,
                controller.value.previewSize.height),
        size.height /
            max(controller.value.previewSize.width,
                controller.value.previewSize.height));
    double logicalHeight = max(controller.value.previewSize.width,
            controller.value.previewSize.height) *
        adjustConstant;
    double logicalWidth = min(controller.value.previewSize.width,
            controller.value.previewSize.height) *
        adjustConstant;

    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/person.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage:
                                ExactAssetImage('assets/person.jpg'),
                            radius: 50,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Барак Обама",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "ЗАЖМИТЕ ЧТОБЫ УДАЛИТЬ ГОСТЯ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              VerticalDivider(
                color: Colors.white,
                width: _thickness,
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/person.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage:
                                ExactAssetImage('assets/person.jpg'),
                            radius: 50,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Барак Обама",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "ЗАЖМИТЕ ЧТОБЫ УДАЛИТЬ ГОСТЯ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.white,
          height: _thickness,
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: ClipRect(
                  child: OverflowBox(
                    minHeight: 0.0,
                    minWidth: 0.0,
                    maxHeight: logicalHeight,
                    maxWidth: logicalWidth,
                    child: SizedBox(
                      width: logicalWidth,
                      height: logicalHeight,
                      child: Transform.scale(
                        scale: 0.5,
                        child: CameraPreview(controller),
                      ),
                    ),
                  ),
                ),
              ),
              VerticalDivider(
                color: Colors.white,
                width: _thickness,
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/person.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage:
                                ExactAssetImage('assets/person.jpg'),
                            radius: 50,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Барак Обама",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "ЗАЖМИТЕ ЧТОБЫ УДАЛИТЬ ГОСТЯ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildFivePeopleView(
      BuildContext context, CameraController controller) {
    Size size = MediaQuery.of(context).size;
    double adjustConstant = max(
        size.width /
            min(controller.value.previewSize.width,
                controller.value.previewSize.height),
        size.height /
            max(controller.value.previewSize.width,
                controller.value.previewSize.height));
    double logicalHeight = max(controller.value.previewSize.width,
            controller.value.previewSize.height) *
        adjustConstant;
    double logicalWidth = min(controller.value.previewSize.width,
            controller.value.previewSize.height) *
        adjustConstant;

    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage('assets/person.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                color: Colors.black.withOpacity(0),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    ExactAssetImage('assets/person.jpg'),
                                radius: 50,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Барак Обама",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "ЗАЖМИТЕ ЧТОБЫ УДАЛИТЬ ГОСТЯ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.white,
                    width: _thickness,
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage('assets/person.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                color: Colors.black.withOpacity(0),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    ExactAssetImage('assets/person.jpg'),
                                radius: 50,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Барак Обама",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "ЗАЖМИТЕ ЧТОБЫ УДАЛИТЬ ГОСТЯ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.white,
              height: _thickness,
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage('assets/person.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                color: Colors.black.withOpacity(0),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    ExactAssetImage('assets/person.jpg'),
                                radius: 50,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Барак Обама",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "ЗАЖМИТЕ ЧТОБЫ УДАЛИТЬ ГОСТЯ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.white,
                    width: _thickness,
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage('assets/person.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                color: Colors.black.withOpacity(0),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    ExactAssetImage('assets/person.jpg'),
                                radius: 50,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Барак Обама",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "ЗАЖМИТЕ ЧТОБЫ УДАЛИТЬ ГОСТЯ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Center(
          child: CircleAvatar(
            radius: 100,
            child: ClipOval(
              child: OverflowBox(
                minHeight: 0.0,
                minWidth: 0.0,
                maxHeight: logicalHeight,
                maxWidth: logicalWidth,
                child: SizedBox(
                  width: logicalWidth,
                  height: logicalHeight,
                  child: Transform.scale(
                    scale: 0.5,
                    child: CameraPreview(controller),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
