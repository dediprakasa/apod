//
//  ApodCell.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/2/20.
//

import SwiftUI

struct ApodCell: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                Image("image_sample")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)

                BlurView()
                    .frame(width: geometry.size.width, height: 54)

                Text("The Scale of the Universe - Interactive")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 2, leading: 16, bottom: 2, trailing: 16))
                
            }
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        }
    }
}

struct ApodCell_Previews: PreviewProvider {
    static var previews: some View {
        ApodCell()
            .frame(height: 200)
    }
}

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
