//
//  SwiftUIView.swift
//  iNimal
//
//  Created by Louis Dupont on 18/05/2022.
//

import SwiftUI

struct LitterView: View {
    var litter: Litter
    @State var tap = false
    var animationDuration = 0.2
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    ZStack {
                        Circle()
                            .strokeBorder(.gray.opacity(0.1), lineWidth: 1)
                            .background(Circle().fill(.white))
                        Text(litter.emoji)
                            .font(.title2)
                    }
                    .frame(width: 48, height: 48)
                    .position(x: 54, y: 68)
                    .shadow(color: .gray.opacity(0.1), radius: 4)
                }
                .frame(height: 68)
                .background(Color("Pastel Green"))
                HStack {
                    Text(litter.name)
                        .font(.headline)
                    Spacer()
                    Text(litter.getTimeRemaining())
                        .font(.largeTitle)
                        .bold()
                }
                .padding([.leading, .trailing], 36)
                .padding([.top, .bottom], 24)
            }
        }
        .border(.gray.opacity(0.1))
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.1), radius: 4)
        /*
        .scaleEffect(tap ? 0.98 : 1)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ gesture in
                    tap = true;
                })
                .onEnded({ gesture in
                    tap = false;
                })
        )
        .animation(.spring(response: animationDuration, dampingFraction: 0.4), value: tap)
         */
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LitterView(litter: Litter(id: 1, name: "Salon", emoji: "🏠", lastClean: Date()))
    }
}
