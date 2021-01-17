//
//  Profile.swift
//  Apod
//
//  Created by Dedi Prakasa on 12/4/20.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("deprak")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .shadow(color: .black, radius: 3, x: 2, y: 2)

            Text("dedprakasa@gmail.com")

            HStack {
                Button(action: {
                    UIApplication.shared.open(URL(string: "https://www.linkedin.com/in/dediprakasa/")!)
                }, label: {
                    Text("LinkedIn")
                })

                Button(action: {
                    UIApplication.shared.open(URL(string: "https://github.com/dediprakasa")!)
                }, label: {
                    Text("Github")
                })

                Button(action: {
                    UIApplication.shared.open(URL(string: "https://www.dicoding.com/users/deltadirac")!)
                }, label: {
                    Text("Dicoding")
                })
            }
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
