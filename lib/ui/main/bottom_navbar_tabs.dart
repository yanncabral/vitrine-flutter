enum BottomNavbarTabs {
  home,
  search,
  bag,
  archived,
  profile,
}

extension ButtonNavbarTabsLabels on BottomNavbarTabs {
  String get title {
    switch (this) {
      case BottomNavbarTabs.home:
        return "Explorar";
      case BottomNavbarTabs.search:
        return "Pesquisar";
      case BottomNavbarTabs.bag:
        return "Favoritos";
      case BottomNavbarTabs.archived:
        return "Arquivados";
      case BottomNavbarTabs.profile:
        return "Perfil";
    }
  }
}
