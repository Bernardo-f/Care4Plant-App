import 'package:care4plant/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../injection_container.dart';
import '../../../../../models/categoria.dart';
import '../../../../provider/get_actividades_by_categoria_provider.dart';
import '../../../../provider/get_categorias_provider.dart';
import '../../../activities/activities.dart';
import '../../../components/circular_primary_indicator.dart';

class ListCategorias extends StatefulWidget {
  const ListCategorias({Key? key}) : super(key: key);

  @override
  ListCategoriasState createState() => ListCategoriasState();
}

class ListCategoriasState extends State<ListCategorias> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GetCategoriasProvider>(builder: (context, provider, child) {
      if (provider.state == GetCategoriasState.loading) {
        return const Center(
          child: circularPrimaryColorIndicator,
        );
      } else if (provider.state == GetCategoriasState.success) {
        return buildCategorias(provider.categorias);
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}

Widget buildCategorias(List<Categoria> categoriasList) {
  return Scrollbar(
      thumbVisibility: true,
      child: ListView.builder(
        itemCount: categoriasList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final categoria = categoriasList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider(
                                create: (_) => GetActividadesByCategoriaProvider(
                                    getActividadesByCategoriaUseCase: sl())
                                  ..init(categoria.id_categoria),
                              ),
                            ],
                            child: Activities(categoria: categoria),
                          )));
            },
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: (index == 0) ? 10 : 30, horizontal: 10),
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(237, 239, 238, .74),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                categoria.nombre_categoria,
                                style: const TextStyle(
                                    color: Color.fromRGBO(58, 60, 62, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                width: 160,
                                child: Text(
                                  categoria.descripcion_categoria,
                                  style: const TextStyle(
                                      color: Color.fromRGBO(110, 112, 115, 1),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        right: 10,
                        bottom: 0,
                        child: SvgPicture.network(apiUrl + categoria.imagen_categoria))
                  ],
                ),
                (index == categoriasList.length - 1)
                    ? const Padding(padding: EdgeInsets.symmetric(vertical: 5))
                    : const SizedBox.shrink()
              ],
            ),
          );
        },
      ));
}
