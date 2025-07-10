import 'package:flutter/material.dart';
import 'package:hns/models/kard.dart';
import 'package:hns/shared/styles.dart';
import 'package:hns/shared/utils.dart';

class WidgetKard extends StatelessWidget {
  final int idKard;
  final TySituation tySituation;
  final void Function() fnRemove;
  final void Function() fnMove;
  final void Function() fnPlay;

  const WidgetKard({required this.idKard, required this.tySituation, required this.fnRemove, required this.fnMove, required this.fnPlay, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getColorKardBkg(idKard),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4.0, top: 4.0),
              child: Image.asset(
                getKardImage(idKard),
                width: 60,
                height: 60,
                color: Colors.white,
                colorBlendMode: BlendMode.multiply, //#14 6m18
              ),
            ),

            SizedBox(width: 3),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //                  StyledHeading(getTyKard(idKard) == TyKard.notset ? "Not set" : getNmKard(idKard)),
                  StyledKardHeading(idKard),

                  if (getTyKard(idKard) != TyKard.notset) StyledKardText(idKard),
                ],
              ),
            ),
            SizedBox(width: 3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    (tySituation == TySituation.drawn)
                        ? styledKardIconButton(idKard, onPressed: fnMove, icon: Icon(Icons.download))
                        : styledKardIconButton(idKard, onPressed: fnPlay, icon: Icon(Icons.arrow_forward)),
                    /*                         ? IconButton(onPressed: fnMove, icon: Icon(Icons.download))
                        : IconButton(onPressed: fnPlay, icon: Icon(Icons.arrow_forward)),
 */
                  ],
                ),
                Row(
                  children: [
                    styledKardIconButton(
                      idKard,
                      onPressed: () {
                        msgBox(context, getRule(idKard));
                      },
                      icon: Icon(Icons.info),
                    ), //#27 1m52
                    styledKardIconButton(idKard, onPressed: fnRemove, icon: Icon(Icons.delete)), //#27 1m52 see fonts.google.com/icons
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
