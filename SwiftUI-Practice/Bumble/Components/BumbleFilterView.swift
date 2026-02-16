//
//  BumbleFilterView.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 14/02/2026.
//

import SwiftUI

struct BumbleFilterView: View {
    var options: [String]
    
    @Binding var selectedOption: String
    @Namespace private var namespace
    
    var body: some View {
        HStack(alignment: .top, spacing: 32) {
            ForEach(options, id: \.self) { option in
                VStack(spacing: 8) {
                    Text(option)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fontWeight(.medium)

                    if selectedOption == option {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height: 1.5)
                            .matchedGeometryEffect(id: "selectedOption", in: namespace)
                    }
                }
                .padding(.top, 8)
                .background(Color.black.opacity(0.001))
                .foregroundStyle(selectedOption == option ? .bumbleBlack : .bumbleGray)
                .onTapGesture {
                    withAnimation(.smooth) {
                        selectedOption = option
                    }
                }
            }
        }
    }
}

fileprivate struct BumbleFilterView_Previews: View {
    var options = ["Option 1", "Option 2", "Option 3"]
    @State var selectedOption: String = "Option 1"
    
    var body: some View {
        BumbleFilterView(options: options, selectedOption: $selectedOption)
            .padding()
    }
}

#Preview {
    BumbleFilterView_Previews()
}
