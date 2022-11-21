//
//  ProductDescriptionView.swift
//  FlipItApp
//
//  Created by ashutosh on 14/09/22.
//

import SwiftUI

struct ProductDescriptionView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var moreImages : [Image] = [Image("iphone12_pro_pg1"), Image("iphone12_pro_pg2"), Image("iphone12_pro_pg3")]
    @State var selectedImageIndex = 0
    @State var selectedColorIndex = 0
    @State var colorList = [Color("pacficBlue"),Color("midnightGreen"),Color("gold"),Color("silver")]
    @State var products : [Any] = []
    @State var currentImage = Image(systemName: "person")
    @State var showMoreDetails = false
    @State var saveToFavourite = false
  @State var showWebView = false
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName:"chevron.left")
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                Spacer()
                VStack(alignment:.leading){
                    Text("Iphone 12 pro")
                        .font(.custom("Verdana", size: 20))
                    Text("$1299.00")
                        .font(.custom("Verdana", size: 18))
                        .bold()
                }
               
            }
            .padding(.leading)
            .padding(.trailing)
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    TabView{
                        ForEach(0..<self.moreImages.count){index in
                            moreImages[index]
                                .resizable()
                                .scaledToFit()
                                .frame(width: Screen.maxWidth, height: Screen.maxWidth*0.6, alignment: .center)
                                .onAppear{
                                    self.currentImage = moreImages[index]
                                    self.selectedImageIndex = index
                                }
                            
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    HStack{
                        ForEach(0..<self.moreImages.count){index in
                            
                            Capsule()
                                .frame(width:self.selectedImageIndex==index ? Screen.maxWidth*0.07 : Screen.maxWidth*0.02, height: Screen.maxWidth*0.02, alignment: .center)
                                .animation(.default)
                                .foregroundColor(Color.gray)
                                .opacity(0.3)
                            
                            
                        }
                    }
                    
                    MoreImagesView(moreImages: self.moreImages, currentImage: $currentImage, selectedImageIndex: $selectedImageIndex)
                    HStack(spacing:0){
                        ForEach(0..<colorList.count){index in
                            if selectedColorIndex==index{
                                ZStack{
                                    Circle()
                                        .stroke(Color.gray)
                                        .frame(width: Screen.maxWidth*0.075, height: Screen.maxWidth*0.075, alignment: .center)
                                        .padding(.leading)
                                    Circle()
                                        .fill(colorList[index])
                                        .frame(width: Screen.maxWidth*0.06, height: Screen.maxWidth*0.06, alignment: .center)
                                        .padding(.leading)
                                }
                            }else{
                                Circle()
                                    .fill(colorList[index])
                                    .frame(width: Screen.maxWidth*0.06, height: Screen.maxWidth*0.06, alignment: .center)
                                    .padding(.leading)
                                    .onTapGesture {
                                        self.selectedColorIndex=index
                                    }
                            }
                        }
                        Spacer()
                        HStack(alignment:.bottom){
                            Button(action: {
                                actionSheet()
                            }, label: {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 22))
                            })
                            .padding(.trailing)
                            
                            Button(action: {
                                self.saveToFavourite.toggle()
                            }, label: {
                                Image(systemName: self.saveToFavourite ? "heart.fill" : "heart")
                                    .font(.system(size: 22))
                                    .accentColor(self.saveToFavourite ? .red : .black)
                            })
                            .padding(.trailing)
                        }
                    }
                    
                    
                    HStack{
                        Text("More details")
                            .font(.custom("Verdana", size: 20))
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.system(size: 17))
                            .rotationEffect(.degrees(self.showMoreDetails ? 180 : 0))
                            .animation(.default)
                            .onTapGesture {
                                
                                self.showMoreDetails.toggle()
                            }
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top)
                    if showMoreDetails{
                        MoreDetailsView()
                    }
                    ZStack{
                        ReviewAndRatingView()
                        HStack{
                            Button(action: {
                                self.showWebView=true
                            }, label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius:Screen.maxWidth*0.03)
                                        .foregroundColor(.white)
                                        .frame(width: Screen.maxWidth*0.4, height: Screen.maxHeight*0.07, alignment: .center)
                                    Text("Website")
                                        .font(.custom("Verdana", size: 16))
                                }
                            })
                            
                            .fullScreenCover(isPresented: $showWebView, content: {
                                WebsiteView()
                            })
                            Spacer()
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius:Screen.maxWidth*0.03)
                                        .foregroundColor(.blue)
                                        .frame(width: Screen.maxWidth*0.4, height: Screen.maxHeight*0.07, alignment: .center)
                                        .opacity(0.8)
                                    
                                    Text("Buy now")
                                        .foregroundColor(.white)
                                        .font(.custom("Verdana", size: 16))
                                }
                            })
                            
                        }.padding(.leading).padding(.trailing)
                    }
                }
            }
        }
        .accentColor(.black)
        .navigationBarHidden(true)
 
        .onAppear{
            self.currentImage = moreImages[selectedImageIndex]
        }
    }
    func actionSheet() {
            guard let urlShare = URL(string: "https://ecommerce.com") else { return }
            let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
}

struct ReviewAndRatingView : View{
    @State var goToReviewsScreen = false
    var body: some View{
        VStack{
        HStack{
                Image("star.fill")
                    .resizable()
                    .frame(width: Screen.maxWidth*0.06, height: Screen.maxWidth*0.06, alignment: .center)
                Text("4.8")
                    .font(.custom("Verdana", size: 18))
                Text("Review and Rating")
                    .font(.custom("Verdana", size: 18))
                Spacer()
            NavigationLink(
                destination: ReviewsScreenView(),
                isActive: $goToReviewsScreen,
                label: {
                    ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.gray)
                        .opacity(0.3)
                        .frame(width: Screen.maxWidth*0.18, height: Screen.maxWidth*0.08, alignment: .center)
                    Text("See all")
                            .font(.custom("Verdana", size: 14))
                    }
                })
               
                
            }
            .padding(.leading)
            .padding(.trailing)
            VStack{
                  ReviewCellView(review: ReviewModel(user: "Erika Jones", rating: 5, date: "Mar 20, 2021", reviewMessage: "great product, fast delivery", profileImage: Image("profilePicture1")))
                   //
                    .cornerRadius(Screen.maxWidth*0.05)
                    .padding()
                Spacer()
            
            }
            .frame( height: 400)
        
            .background(Color("background"))
            .cornerRadius(Screen.maxWidth*0.05)
          
        }
    }
}
struct ReviewCellView : View{
    var review : ReviewModel
    var body : some View{
        VStack(alignment:.leading){
            HStack{
                ZStack{
                    Circle()
                        .stroke(Color.gray)
                    review.profileImage
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                }  .frame(width: Screen.maxWidth*0.13, height:  Screen.maxWidth*0.13, alignment: .center)
                
                VStack(alignment:.leading){
                    Text(review.user)
                        .font(.custom("Verdana", size: 16))
                    Text(review.date)
                        .font(.custom("Verdana", size: 14))
                        .foregroundColor(.gray)
                        .opacity(0.7)
                }
                .padding(.leading,5)
                Spacer()
                HStack{
                    ForEach(0..<review.rating){star in
                        Image("star.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: Screen.maxWidth*0.04, height:  Screen.maxWidth*0.04, alignment: .center)
                    }
                }
            }
           
            Text(review.reviewMessage)
                .font(.custom("Verdana", size: 14))
                .foregroundColor(.gray)
                .opacity(0.7)
        } .padding()
        .cornerRadius(Screen.maxWidth*0.05)
        .background(Color.white)
     
    }
}
struct MoreImagesView : View{
    var moreImages : [Image]
    @Binding var currentImage : Image
    @Binding var selectedImageIndex : Int
    var body: some View{
        HStack(spacing:0){
            ForEach(0..<moreImages.count){index in
                ZStack{
                    if self.selectedImageIndex==index{
                    RoundedRectangle(cornerRadius: Screen.maxWidth*0.03)
                        .stroke(Color.gray,lineWidth: 2.5)
                    }else{
                        RoundedRectangle(cornerRadius: Screen.maxWidth*0.04)
                            .fill(Color("background"))
                    }
                    moreImages[index]
                        .resizable()
                        .scaledToFit()
                }
                .frame(width: Screen.maxWidth*0.2, height: Screen.maxHeight*0.08, alignment: .center)
                .padding(.leading)
                .onTapGesture {
                    self.selectedImageIndex=index
                   self.currentImage = moreImages[selectedImageIndex]
                }
              
            }
            Spacer()
        }
    }
}

struct WebsiteView : View{
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        VStack{
            HStack{
                Image(systemName : "plus")
                    .rotationEffect(.degrees(45))
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                Spacer()
                Text("Iphone 12 pro")
                    .font(.custom("Verdana", size: 18))
                    .bold()
                Spacer()
             
            }.padding(.leading).padding(.trailing)
            Spacer()
            WebView(url: URL(string:"https://www.apple.com/in/iphone-12-pro/?afid=p238%7Csi5YG1Idt-dc_mtid_209254ho67063_pcrid_536173594258_pgrid_124995589678_&cid=wwa-in-kwgo-iphone-slid----Avail-"))
        }
    }
}
struct MoreDetailsView : View{
    var list = [
        "128 GB ROM",
        "15.49 cm (6.1 inch) Super Retina XDR Display",
        "12MP + 12MP + 12MP | 12MP Front Camera",
        "A14 Bionic Chip with Next Generation Neural Engine Processor",
        "Ceramic Shield | Industry-leading IP68 Water Resistance",
        "All Screen OLED Display",
        "LiDAR Scanner for Improved AR Experiences, Night Mode Portraits"
    ]
    var body: some View{
        VStack(alignment:.leading){
            Text("Highlights")
                .font(.custom("Verdana", size: 16))
                .bold()
                .padding(.top)
            VStack(alignment:.leading,spacing:5){
                ForEach(list,id:\.self){item in
                    HStack{
                        Text("•")
                        Text(item)
                            .font(.custom("Verdana", size: 16))
                    }.accentColor(.gray)
                }
            }.padding(.top,5)
        }
        .padding(.top,5)
        .padding(.leading)
        .padding(.trailing)
    }
}
struct ProductDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDescriptionView()
    }
}
