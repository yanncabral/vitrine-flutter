enum BottomNavbarTabs {
  home,
  search,
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
      case BottomNavbarTabs.archived:
        return "Favoritos";
      case BottomNavbarTabs.profile:
        return "Perfil";
    }
  }
}
