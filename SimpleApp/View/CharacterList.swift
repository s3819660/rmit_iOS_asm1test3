//
//  CharacterList.swift
//  SimpleApp
//
//  Created by Phuc Nguyen Phuoc Nhu on 26/07/2022.
//
//        thehappyprogrammer.com/custom-list-in-swiftui
import SwiftUI


struct smallcardView: View {
    var p: Character
    let namespace: Namespace.ID
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: p.image)) { image in
                image.resizable()
            } placeholder: {
                Color.red
            }
            .frame(width: 150, height: 150)
//            .clipShape(RoundedRectangle(cornerRadius: 25))




            VStack {
                Text(p.name)
                Text(p.origin.name)
                Text(p.status)
            }
        }
        
//        GeometryReader { g in
//            VStack(alignment: .leading) {
//                HStack {
////                    Image()
////                        .resizable()
////                        .frame(width: 120, height: 90)
////                        .cornerRadius(10)
////                        .matchedGeometryEffect(id: "image", in: namespace)
//                    AsyncImage(url: URL(string: p.image)) { image in
//                        image.resizable()
//                    } placeholder: {
//                        Color.red
//                    }
//                    .frame(width: 120, height: 90)
//                    .cornerRadius(10)
//                    .matchedGeometryEffect(id: "image", in: namespace)
//
//                    VStack(alignment: .leading) {
////                        blurTags(tags: p.postType, namespace: namespace)
//                        Spacer()
//                        Text(p.name)
//                            .foregroundColor(Color.white)
////                            .matchedGeometryEffect(id: "title", in: namespace)
//                        Spacer()
//                    }.padding(.leading)
//                    Spacer()
////                    VStack {
////                        Image(systemName: "ellipsis")
////                            .foregroundColor(Color.white)
//////                            .matchedGeometryEffect(id: "ellipsis", in: namespace)
////                        Spacer()
////                    }
//                }
//            }
//        }
    }
}

struct blurTags:  View {
    
    var tags: Array<String>
    let namespace: Namespace.ID
    var body: some View {
        HStack {
            ForEach(tags, id: \.self) { tag in
                Text("\(tag)")
                    .fontWeight(.semibold)
                    .foregroundColor(.yellow)
                    .font(.caption)
                    
            }
        }.matchedGeometryEffect(id: "tags", in: namespace)
    }
}

//struct BlurView: UIViewRepresentable {
//
//    let style: UIBlurEffect.Style
//
//    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .clear
//        let blurEffect = UIBlurEffect(style: style)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.translatesAutoresizingMaskIntoConstraints = false
//        view.insertSubview(blurView, at: 0)
//        NSLayoutConstraint.activate([
//            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
//            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
//        ])
//        return view
//    }
//
//    func updateUIView(_ uiView: UIView,
//                      context: UIViewRepresentableContext<BlurView>) {
//
//    }
//}

struct BlurView: View {
    
    var body: some View {
        HStack {
            Color.gray
        }.opacity(0.2)
    }
}

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}

struct BackgroundView: View {
    var body: some View {
        Image("space")
            .centerCropped()
            .edgesIgnoringSafeArea(.all)
    }
}


struct CharacterList: View {
    
    @EnvironmentObject var characterViewModel: CharacterViewModel
    
//    var body: some View {
////        Text("hello world")
//        Text("hello world, \(characterViewModel.characters[characterViewModel.characters.startIndex].name)")
//    }
    @Namespace var namespace
    var body: some View {
            NavigationView {
                
//                HStack{
//                    ZStack {
//                        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
//                        VStack {
//                            Capsule()
//                                .fill(Color.orange)
//                                .frame(width: 200, height: 200)
//                                .offset(x: -150, y: -55)
//                            Spacer()
//                            Capsule()
//                                .fill(Color.orange)
//                                .frame(width: 200, height: 200)
//                                .offset(x: 150, y: 105)
//                        }
                        
                        ScrollView {
                            // list title
                            HStack {
                                Image(systemName: "text.justify")
                                    .font(.title3)
                                    .foregroundColor(Color.white)
                                Spacer()
                                Image("logo")
                                    .resizable()
                                    .frame(width: 130, height: 40)
                                Spacer()
                                Image(systemName: "bell")
                                    .font(.title2)
                                    .foregroundColor(Color.white)
                            }.padding(.horizontal)
                            
                            // list
                            VStack(alignment: .leading) {
                                ForEach(characterViewModel.characters) { p in
                                    NavigationLink(destination: CharacterCard(character: p)) {
                                        CharacterRow(character: p)
//                                                .padding()
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 150)
//                                                .background(BlurView(style: .regular))
                                                .background(BlurView())
                                                .cornerRadius(10)
                                                .padding(.vertical, 6)
                                                .padding(.horizontal)
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .navigationBarHidden(true)
                        .background(BackgroundView())
//                    }
//                }
            }
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList()
            .environmentObject(CharacterViewModel())
    }
}
