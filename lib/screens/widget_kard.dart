import 'package:flutter/material.dart';
import 'package:hns/models/kard.dart';
import 'package:hns/shared/styles.dart';
import 'package:hns/screens/utils.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              getKardImage(idKard),
              width: 60,
              height: 60,
              color: Colors.white,
              colorBlendMode: BlendMode.multiply, //#14 6m18
            ),
            SizedBox(width: 3),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StyledHeading(getTyKard(idKard) == TyKard.notset ? "Not set" : getNmKard(idKard)),
                  if (getTyKard(idKard) != TyKard.notset) StyledText(getDesc(idKard)),
                ],
              ),
            ),
            SizedBox(width: 3),
            Column(
              children: [
                (tySituation == TySituation.drawn)
                    ? IconButton(onPressed: fnMove, icon: Icon(Icons.download))
                    : IconButton(onPressed: fnPlay, icon: Icon(Icons.arrow_forward)),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        msgBox(context, getRule(idKard));
                      },
                      icon: Icon(Icons.info),
                    ), //#27 1m52
                    IconButton(onPressed: fnRemove, icon: Icon(Icons.delete)), //#27 1m52 see fonts.google.com/icons
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
