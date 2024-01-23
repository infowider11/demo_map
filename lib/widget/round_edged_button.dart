import 'package:flutter/material.dart';


class RoundEdgedButton extends StatelessWidget {
  final double? height;
  final Color? color;
  final Color? borderColor;
  final String text;
  final String? fontfamily;
  final Function()? onTap;
  final double horizontalMargin;
  final double iconHeight;
  final double iconWidth;
  final double verticalPadding;
  final double horizontlyPadding;
  final double verticalMargin;
  // final Gradient? gradient;
  final bool isSolid;
  final bool isWhite;
  final bool isBorder;
  final Color? textColor;
  final double? borderRadius;
  final bool isBold;
  final TextAlign textAlign;
  final bool isIconStart;
  final double? fontSize;
  final double? width;
  final String? icon;
  final bool showGradient;
  final FontWeight? fontWeight;
  final bool load;

  const RoundEdgedButton(
      {Key? key,
      this.color ,
      this.borderColor,
      required this.text,
      this.isWhite = false,
      this.fontfamily,
      this.onTap,
      this.textAlign = TextAlign.center,
      this.horizontlyPadding = 8,
      this.horizontalMargin = 0,
      this.iconHeight = 18,
      this.iconWidth = 12,
      this.textColor,
      this.borderRadius = 15,
      this.isBold = false,
      this.isIconStart = true,
      this.isBorder = false,
      this.verticalMargin = 12,
      this.verticalPadding = 0,
      this.width,
      this.fontSize = 16,
      this.icon,
      this.showGradient = false,
      this.height = 50,
      this.fontWeight = FontWeight.w600,
      this.load = false,
      // required this.hasGradient,
      this.isSolid = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: load ? null : onTap,
      child: Container(
          height: height,
          margin: EdgeInsets.symmetric(
              horizontal: horizontalMargin, vertical: verticalMargin),
          width: width ?? (MediaQuery.of(context).size.width),
          padding: EdgeInsets.symmetric(
              horizontal: horizontlyPadding, vertical: verticalPadding),
          decoration: BoxDecoration(
            color: isWhite
                ? Colors.white
                : isSolid
                    ? color
                    : Colors.transparent,
            // gradient: hasGradient?gradient ??
            //     LinearGradient(
            //       colors: <Color>[
            //         Color(0xFF064964),
            //         Color(0xFF73E4D9),
            //       ],
            //     ):null,
            gradient: showGradient
                ? const LinearGradient(
                    // begin: FractionalOffset.topRight,
                    // end: FractionalOffset.bottomCenter,
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xfff02321),
                      Color(0xff781211),
                    ],
                  )
                : null,
            borderRadius: BorderRadius.circular(borderRadius!),
            border:isBorder?Border.all(color:Color(0xff6B7943)): isSolid ? null : Border.all(color: Color(0xff6B7943)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null && isIconStart)
                Padding(
                  padding: EdgeInsets.only(
                      left: textAlign == TextAlign.center ? 10.0 : 0),
                  child: Image.asset(
                    icon!,
                    height: iconHeight,
                    width: iconWidth,
                  ),
                ),
              if (icon != null && isIconStart) SizedBox(height: 10,),
              Flexible(
                child: Text(
                  text,
                  textAlign: textAlign,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize ?? 24,
                      fontWeight: fontWeight ?? FontWeight.w600,
                      fontFamily: fontfamily

                      // letterSpacing: 2,
                      ),
                ),
              ),
              if (icon != null && isIconStart == false)
                Padding(
                  padding: EdgeInsets.only(
                    right: textAlign == TextAlign.center ? 5.0 : 0,
                    left: textAlign == TextAlign.center ? 5.0 : 0,
                  ),
                  child: Image.asset(
                    icon!,
                    height: iconHeight,
                    width: iconWidth,
                  ),
                ),
            ],
          )),
    );
  }
}
