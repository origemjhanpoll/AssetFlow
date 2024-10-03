import 'package:asset_flow/domain/entities/branch.dart';
import 'package:asset_flow/domain/repositories/i_assets_repository.dart';
import 'package:asset_flow/utils/item_type.dart';
import 'package:asset_flow/utils/set_type.dart';

class GetTree {
  final IAssetsRepository repository;

  GetTree(this.repository);

  Future<List<Branch>> call({required String companyId}) async {
    var locations = await repository.getLocations(companyId: companyId);
    var assets = await repository.getAssets(companyId: companyId);

    // Atribui os tipos corretos a assets e locations
    assets = assets
        .map((element) => element.copyWith(type: setType(element)))
        .toList();

    locations = locations
        .map((element) => element.copyWith(type: ItemType.location))
        .toList();

    // Junta os assets e locations
    final branchs = [...assets, ...locations];

    // Organiza a árvore
    List<Branch> tree = _buildTree(branchs);

    return tree;
  }
}

// Função para organizar a árvore
List<Branch> _buildTree(List<Branch> branchs) {
  // Mapa para armazenar elementos por id
  Map<String, Branch> map = {for (var item in branchs) item.id: item};

  // Lista de elementos principais (sem parentId ou locationId)
  List<Branch> tree = [];

  for (var item in branchs) {
    var parentId = item.parentId;
    var locationId = item.locationId;

    if (parentId != null && map.containsKey(parentId)) {
      // Adiciona o item como filho na chave "branch" do elemento pai
      map[parentId]?.branches.add(item);
    } else if (locationId != null && map.containsKey(locationId)) {
      // Adiciona o item como filho na chave "branch" do elemento location
      map[locationId]?.branches.add(item);
    } else {
      // Caso não tenha parentId nem locationId, é um nó raiz
      tree.add(item);
    }
  }

  return tree;
}
