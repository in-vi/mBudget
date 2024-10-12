//
//  headerView.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import SwiftUI

struct headerView: View {
    let title : String
    let subTitle : String
    let angle : Double
    let background : Color
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 0)
                .foregroundStyle(background)
                .rotationEffect(Angle(degrees: angle))
                
            VStack{
                Text(title)
                    .font(.system(size:50))
                    .foregroundStyle(Color.white)
                    .bold()
                Text(subTitle)
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
            }
            .padding(.top,80)
        }
        .frame(width: UIScreen.main.bounds.width*3,
               height:350)
        .offset(y:-150)
    }
}

#Preview {
    headerView(title:"main Title",
               subTitle:"subTitle",
               angle:15,
               background:.blue)
}
