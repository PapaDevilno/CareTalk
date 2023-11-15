//
//  GalleryView.swift
//  CareTalk
//
//  Created by ichiro on 05/11/23.
//

//import SwiftUI
//
//struct GalleryView: View {
//    
//    @ObservedObject var galleryViewModel = GalleryViewModel()
//    //@Binding var isExpanded: Bool
//    
//    @State var count = 0
//    
//    var body: some View {
//        
//        
//        ZStack {
//            Color(AppColor.blue)
//                .edgesIgnoringSafeArea(.all)
//            VStack{
//                Text(StringResources().galleryTitle)
//                    .fontWeight(.semibold)
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
//                    .padding(.bottom, 20)
//                
//                //ScrollView{
//                VStack{
//                    ForEach(0..<galleryViewModel.galleryItems.count-3, id: \.self) { index in
//                        
//                        VStack{
//                            RecordingFile(galleryViewModel: galleryViewModel, count: $count, index: index)
//                            
//                            
//                            
//                        }
//                        //.frame(height: .infinity)
//                        .padding(.bottom, 10)
//                    }
//                }
//                
//                //                }//.frame(height: .infinity)
//                //                    .border(Color.black)
//                
//                //Spacer()
//                
//                //                ZStack{
//                //
//                //
//                //                    VStack(alignment: .leading){
//                //                        Text(StringResources().galleryDesc_Third)
//                //                            .foregroundColor(.white)
//                //                        VStack{
//                //                            Text(StringResources().swipeRight).foregroundColor(AppColor.pink)
//                //                            +  Text(StringResources().galleryDesc_Fourth)
//                //
//                //                                .foregroundColor(.white)
//                //
//                //                        }.padding(.top, 20)
//                //                    }.frame(width: 300)
//                //                        .padding(.bottom, 90)
//                //
//                //                    //di main nnti hapus height sama ganti padding .bottom jdi 90
//                //                }
//                
//                
//                //ZStack{
//                
//                
//                
//                switch count {
//                    case 0:
//                        VStack(alignment: .leading){
//                            Text(StringResources().galleryDesc_First)
//                                .foregroundColor(.white)
//                            
//                            VStack(alignment: .leading){
//                                Text(StringResources().galleryDesc_Second)
//                                    .foregroundColor(.white)
//                                
//                            }.padding(.top, 20)
//                        }.frame(width: 300)
//                    case 1:
//                        VStack(alignment: .leading){
//                            Text(StringResources().pressClose)
//                                .foregroundColor(.white)
//                        }.frame(width: 300)
//                    case 2:
//                        VStack(alignment: .leading){
//                        Text(StringResources().galleryDesc_Third)
//                            .foregroundColor(.white)
//                            
//                            VStack(alignment: .leading){
//                                Text(StringResources().swipeRight).foregroundColor(.white)
//                                    .bold()
//                            }.padding(.top, 20)
//                        }.frame(width: 300)
//                    default:
//                        Text("")
//                }
//               
//                        //.padding(.bottom, 270)
//                Spacer()
//                
////                Button(action: {
////                    galleryViewModel.isExpanded = false
////                }){
////                    Text("This Button")
////                }
////                VStack{
////                    CloseButton()
////                }
////                .onTapGesture {
////                    galleryViewModel.isExpanded = false
////                    galleryViewModel.isClosed = true
////                }
//                    //di main nnti hapus height sama ganti padding .bottom jdi 90
//                
//                    //di main nanti enable scrollviewnya
//                    //di main nanti hapus Spacer() di bawah width: 300
//                //}
//                
//                
//                
//                
//            }
//        }
//    }
//}
//
//#Preview {
//    GalleryView()
//}
