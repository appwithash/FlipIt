//
//  ProductCellView.swift
//  FlipItApp
//
//  Created by ashutosh on 14/09/22.
//

import SwiftUI



struct ProductView : View {
    @State var goToProductDesc = false
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing:0){
                ForEach(0..<5){val in
                NavigationLink(
                    destination: ProductDescriptionView(),
                    isActive: $goToProductDesc,
                    label: {
                        ProductCellView(index: val)
                            .padding(.leading)
                            .onTapGesture {
                                self.goToProductDesc=true
                            }
                    })
                        
                }
            }
        }
    }
}
struct ProductCellView:View{
    var index : Int
    var body: some View{
        VStack{
            HStack{
                Image("apple")
                    .resizable()
                    .scaledToFill()
                    .frame(width: Screen.maxWidth*0.08, height: Screen.maxWidth*0.08, alignment: .center)
                Spacer()
                Image("star.fill")
                    .resizable()
                    .frame(width: Screen.maxWidth*0.05, height: Screen.maxWidth*0.05, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("4.5")
                    .font(.custom("Verdana", size: 15))
                  
            }
            .padding(.leading,5)
            .padding(.trailing)
            
            Image(index%2==0 ? "iphone12_pro_pg1" : "iphones12")
                .resizable()
                .scaledToFit()
                .frame(width: Screen.maxWidth*0.3, height: Screen.maxWidth*0.3, alignment: .center)
            HStack{
                VStack(alignment:.leading){
                    Text(index%2==0 ? "$1299" : "$999")
                    .font(.custom("Verdana", size: 15))
                    .bold()
                    Text(index%2==0 ? "Iphone 12 pro" : "Iphone 12")
                    .font(.custom("Verdana", size: 15))
                    .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(systemName: "bookmark")
                        .resizable()
                        .frame(width: Screen.maxWidth*0.035, height: Screen.maxWidth*0.045, alignment: .center)
                        .foregroundColor(.gray)
                })
            }
            .padding(.leading)
            .padding(.trailing)
          
        }
        .frame(width: Screen.maxWidth*0.43, height: Screen.maxWidth*0.6, alignment: .center)
        .background(Color.white)
        .cornerRadius(Screen.maxWidth*0.05)
    }
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
       ProductView()
    }
}
