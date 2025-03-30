import SwiftUI
import SDWebImageSwiftUI

struct SplashView: View {
    @State private var isVisible = false
    @State private var navigateToMain = false
    
    var body: some View {
        if navigateToMain {
            MainView()
        } else {
            VStack {
                Image("dbz_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                VStack {
                    Text("¡Bienvenido! \n Al universo de Dragon Ball")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 15)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                VStack {
                    VStack {
                        Text("Haz clic en 'Continuar' y sumérgete en el universo de Dragon Ball")
                            .font(.headline)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    Button(action: {
                        navigateToMain = true
                    }) {
                        Text("Continuar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(45)
                    }
                    .padding(.horizontal, 20)
                    
                    HStack {
                        Text("Desarrollado por la Corporación Cápsula")
                            .font(.system(size: 12))
                        Image("capsule_icon")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
                .padding(.horizontal)
                .offset(y: isVisible ? 0 : 100)
                .opacity(isVisible ? 1 : 0)
                .onAppear {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0)) {
                        isVisible = true
                    }
                }
            }
            .background(AnimatedImage(url: URL(string: "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/824db09a-100c-42c1-a47a-d450bd00e595/dc6but6-a03d853d-502b-47e1-913f-55738c886211.gif?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzgyNGRiMDlhLTEwMGMtNDJjMS1hNDdhLWQ0NTBiZDAwZTU5NVwvZGM2YnV0Ni1hMDNkODUzZC01MDJiLTQ3ZTEtOTEzZi01NTczOGM4ODYyMTEuZ2lmIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.1lKLRUqzCMIgIeF-NyVvgROCo8JrUqycYBZ1kj_XUzk")))
            .padding(.vertical)
        }
    }
}

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Personajes", systemImage: "house.fill")
                }
            SearchView()
                .tabItem {
                    Label("Buscar", systemImage: "magnifyingglass")
                }
            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person.fill")
                }
        }
        .accentColor(.white)
        .background(Color.blue)
    }
}



struct HomeView: View {
    @State private var charactersDBZ: [DBZCharacter] = []

    var body: some View {
        ItemList(charactersDBZ: charactersDBZ)
            .onAppear() {
                getDBZ()
            }
    }

    func getDBZ() {
        APIService().fetchCharacters() { result in
            switch result {
            case .success(let dbz):
                self.charactersDBZ = dbz.items
            case .failure(let error):
                print(error)
            }
        }
    }
}



struct ItemList: View {
    var charactersDBZ: [DBZCharacter]
    
    var body: some View {
        VStack {
            NavigationView {
                List(charactersDBZ) { character in
                    NavigationLink(destination: ViewCompleteCharacter(character: character)){
                        HStack {
                            AsyncImage(url: URL(string: character.image)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            Text(character.name)
                                .font(.headline)
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets())
                .navigationTitle("Personajes DBZ")
            }
        }
    }
}

struct ViewCompleteCharacter: View {
    @State private var isVisible = false
    @Environment(\.dismiss) var dismiss
    var character: DBZCharacter
    
    var body: some View {
        VStack {
            VStack {
                if let imageUrlString = character.originPlanet?.image, !imageUrlString.isEmpty {
                    AsyncImage(url: URL(string: imageUrlString)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 350, height: 350)
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Text("No image available")
                }

                Text(character.name)
                    .font(.largeTitle)
                    .padding()
            }.padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
                .padding(.horizontal)
                .offset(y: isVisible ? 0 : 100)
                .opacity(isVisible ? 1 : 0)
                .onAppear {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0)) {
                        isVisible = true
                    }
                }
                .navigationTitle(character.name)
        }.navigationBarItems(leading:
        Button(action: {
            dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .font(.title)
                Text("Atrás")
                    .font(.headline)
            }
            .foregroundColor(.blue)
        
        }.frame(maxWidth: .infinity, alignment: .leading))
        
    }
}





struct SearchView: View {
    var body: some View {
        Text("Vista de Buscar")
            .font(.largeTitle)
            .padding()
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Vista de Perfil")
            .font(.largeTitle)
            .padding()
    }
}

#Preview {
    SplashView()
    //ItemList()
}

