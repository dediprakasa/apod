//
//  DetailView.swift
//  Apod
//
//  Created by Dedi Prakasa on 11/29/20.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var presenter: DetailPresenter
    
    var body: some View {
        Text("Detail, World!")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Details")
    }
}
