import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/services/l10n/l10n_service.dart';
import '../../../../../env.dart';
import '../../../../../models/recomendacion.dart';
import '../../../../provider/get_categorias_recomendadas_provider.dart';
import '../../../activities/activities.dart';

class CategoriasRecomendadas extends StatefulWidget {
  final Function(int) changeTab;
  const CategoriasRecomendadas({Key? key, required this.changeTab}) : super(key: key);

  @override
  CategoriasRecomendadasState createState() => CategoriasRecomendadasState();
}

class CategoriasRecomendadasState extends State<CategoriasRecomendadas> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GetCategoriasRecomendadasProvider>(builder: (context, provider, child) {
      if (provider.state == GetCategoriasRecomendadasState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (provider.state == GetCategoriasRecomendadasState.error) {
        return const SizedBox.shrink();
      } else if (provider.state == GetCategoriasRecomendadasState.success) {
        return builRecomendaciones(provider.categoriasRecomendadas, context, widget.changeTab);
      }
      return const SizedBox.shrink();
    });
    // return FutureBuilder(
    //   future: _recomendaciones,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return builRecomendaciones(snapshot.data!, context, widget.changeTab);
    //     }
    //     return const SizedBox.shrink();
    //   },
    // );
  }
}

Widget builRecomendaciones(
    List<Recomendacion> recomendaciones, BuildContext context, Function(int) changeTab) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 50),
    width: MediaQuery.of(context).size.width * .9,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        offset: const Offset(4, 5),
        blurRadius: 6,
      ),
    ], color: const Color.fromRGBO(227, 235, 228, 1), borderRadius: BorderRadius.circular(25)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            L10nService.localizations.recommenedePath,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Color.fromRGBO(78, 146, 103, 1), fontSize: 16),
          ),
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: recomendaciones.length,
            itemBuilder: ((context, index) {
              final item = recomendaciones[index];
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) {
                    return Activities(categoria: item.categoria);
                  })));
                },
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25), // Color de la sombra
                                offset: const Offset(2, 4), // Desplazamiento horizontal y vertical
                                blurRadius: 6, // Desenfoque
                              ),
                            ],
                            color: (item.recom_realizada)
                                ? const Color.fromRGBO(187, 192, 191, 1)
                                : const Color.fromRGBO(237, 243, 242, 1),
                            shape: BoxShape.circle),
                        child: SvgPicture.network(
                          apiUrl + item.categoria.icono_categoria,
                          width: 20,
                          fit: BoxFit.cover,
                        ),
                      ),
                      (index < recomendaciones.length - 1)
                          ? Container(
                              width: 1.0, // Ancho de la línea
                              height: 40.0,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(187, 192, 191, 1), // Color de la línea
                              ),
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
                  Flexible(
                      child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.categoria.nombre_categoria,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(58, 60, 62, 1),
                              fontSize: 15),
                        ),
                        Text(
                          (item.recom_realizada)
                              ? L10nService.localizations.welldone
                              : L10nService.localizations.toDo,
                          style: const TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ))
                ]),
              );
            })),
        InkWell(
          onTap: () {
            changeTab(2);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.bottomCenter,
            child: Text(
              L10nService.localizations.toExplore,
              style: const TextStyle(
                  color: Color.fromRGBO(61, 87, 50, 1),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  decoration: TextDecoration.underline),
            ),
          ),
        )
      ],
    ),
  );
}
