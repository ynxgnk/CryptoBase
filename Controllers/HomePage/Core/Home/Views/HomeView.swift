//
//  HomeView.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 28/11/22.
//



import SwiftUI

struct HomeView: View { /* 572 */
    @StateObject var viewModel = HomeViewModel() /* 572 */
    
    var body: some View { /* 572 */
        NavigationView { /* 572 */
            ZStack { /* 572 */
                ScrollView(.vertical, showsIndicators: false) { /* 572 */

                    // top movers view
                    TopMoversView(viewModel: viewModel) /* 572 */
                    
                    Divider() /* 572 */
                    // all coins view
                    AllCoinsView(viewModel: viewModel) /* 572 */
                } // Sc

                if viewModel.isLoadingData{ /* 572 */
                    CustomLoadingIndicator() /* 572 */
                }
                    
            } //ZS
//            .navigationTitle("Live Prices")
            
        } //nav

    } //someView
    
} // homeV

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}




