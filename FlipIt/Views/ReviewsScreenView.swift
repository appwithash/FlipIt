//
//  ReviewsScreenView.swift
//  FlipItApp
//
//  Created by ashutosh on 14/09/22.
//

import SwiftUI

struct ReviewsScreenView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var reviewList : [ReviewModel] = [
        ReviewModel( user: "Dean Winchester", rating: 5, date: "may 11 2020", reviewMessage: "fast deliver, good service, awesome product", profileImage: Image("profilePicture4")),
        ReviewModel( user: "Sam Winchester", rating: 5, date: "Apr 28 2020", reviewMessage: "fast deliver, good service, awesome product", profileImage: Image("profilePicture5")),
        ReviewModel( user: "Rowena", rating: 5, date: "Mar 20 2020", reviewMessage: "fast deliver, good service, awesome product", profileImage: Image("profilePicture1")),
        ReviewModel( user: "Crowley", rating: 5, date: "feb 11 2020", reviewMessage: "fast deliver, good service, awesome product", profileImage: Image("profilePicture8")),
        ReviewModel( user: "Castiel", rating: 5, date: "feb 01 2020", reviewMessage: "fast deliver, good service, awesome product", profileImage: Image("profilePicture6")),
        ReviewModel( user: "Alicia Fobes", rating: 5, date: "Jan 12 2020", reviewMessage: "fast deliver, good service, awesome product", profileImage: Image("profilePicture2")),
        ReviewModel( user: "Dean Winchester", rating: 5, date: "Dec 16 2019", reviewMessage: "fast deliver, good service, awesome product", profileImage: Image("profilePicture4")),
        ReviewModel( user: "Mary Winchester", rating: 5, date: "Dec 01 2019", reviewMessage: "fast deliver, good service, awesome product", profileImage: Image("profilePicture3")),
        ReviewModel( user: "Samuel Camphel", rating: 5, date: "Nov 11 2019", reviewMessage: "fast deliver, good service, awesome product", profileImage: Image("profilePicture7")),
    ]
    var body: some View {
        ZStack{
            Color("background").ignoresSafeArea()
            VStack{
                HStack{
                    Image(systemName: "chevron.left")
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    Spacer()
                Text("Reviews and rating")
                    .font(.custom("Verdana", size: 18))
                    .bold()
                    Spacer()
                }
               
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack{
                        ForEach(self.reviewList){review in
                            ReviewCellView(review: review)
                                .cornerRadius(Screen.maxWidth*0.05)
                        }
                    }
                })
            }
            .padding(.leading)
            .padding(.trailing)
          .navigationBarHidden(true)
        }
    }
}

struct ReviewsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsScreenView()
    }
}
