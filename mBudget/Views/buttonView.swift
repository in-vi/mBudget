//
//  buttonView.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import SwiftUI

struct buttonView: View {
    
    let name : String
    let background : Color
    let action :() -> Void
    var body: some View {
        Button{
         // to login
            action()
        }label: {

            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                Text(name)
                    .foregroundColor(Color.white)
                    .bold()
            }
            .frame(width: 150.0, height: 40.0)
        }
    }
}

#Preview {
    buttonView(name:"bt Name",
               background:.blue)
    {
        // action
    }
}
