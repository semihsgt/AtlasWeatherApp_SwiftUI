//
//  ExploreCardView
//  Atlas Weather
//
//  Created by Semih Söğüt on 22.12.2025.
//

import SwiftUI

struct ExploreCardView: View {
    let country: CountryModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Image(systemName: "globe.europe.africa.fill")
                        .font(.system(size: 15))
                    Text("EXPLORE")
                        .font(.system(size: 15))
                    Image(systemName: "chevron.forward")
                        .font(.system(size: 15))
                }
                .foregroundStyle(.white)
                .opacity(0.5)
                
                Divider()
                    .background(Color.white)
                    .opacity(0.5)
                
                HStack {
                    Text("\(country.name) - \(country.flag) \(country.id) \(country.currencies.symbol)")
                    Spacer()
                    Text(country.region)
                }
                .padding(.top, 5)
                .padding(.bottom, 5)
            }
            
            
            Text("\(country.summary.prefix(240))...")
                .multilineTextAlignment(.leading)
                .font(.system(size: 12.5))
                .padding(.top, 10)
            
        }
        .font(.system(size: 15))
        .foregroundStyle(.white)
        .padding()
        .background {
            ColorManager.backgroundColor()
        }
    }
}

#Preview {
    ZStack {
        SkyGradients.dayGradient
            .ignoresSafeArea()
        VStack {
            ExploreCardView(country: CountryModel.mockData())
        }
    }
}
