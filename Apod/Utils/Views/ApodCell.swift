//
//  ApodCell.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/2/20.
//

import SwiftUI
import Combine

struct ApodCell: View {
    
    var apod: Apod

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                Image("image_sample")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)

                ZStack {
                    BlurView()
                        .frame(width: geometry.size.width, height: 54)

                    Text(self.apod.title)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 2, leading: 16, bottom: 4, trailing: 16))
                        .frame(width: geometry.size.width, alignment: .leading)
                }

            }
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        }
    }
}

//struct ApodCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ApodCell(apod: )
//            .frame(height: 200)
//    }
//}

struct BlurView: UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {

        let view = UIView()
        view.backgroundColor = .clear

        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)

        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)

        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        return view
    }

    func updateUIView(
      _ uiView: UIView,
      context: UIViewRepresentableContext<BlurView>
    ) {}
}

struct ApodCell_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
