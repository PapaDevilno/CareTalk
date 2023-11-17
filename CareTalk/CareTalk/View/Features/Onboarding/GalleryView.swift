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
//    @ObservedObject var viewModel: OnboardingViewModel
//    //@Binding var isExpanded: Bool
//    @State private var isMainPagePresented = false
//    @Environment(\.presentationMode) var presentationMode
//    
//    
//    @State var count = 0
//    
//    var body: some View {
//        
//        NavigationView{
//        ZStack {
//            Color(AppColor.blue)
//                .edgesIgnoringSafeArea(.all)
//            VStack(alignment: .leading){
//                Text(StringResources().galleryTitle)
//                    .fontWeight(.semibold)
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
//                    .padding(.bottom, 10)
//                    .padding(.leading, 20)
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
//                        .padding(.bottom, 90)
//                    }
//                }
//                
//                //                }//.frame(height: .infinity)
//                //                    .border(Color.black)
//                
//                Spacer()
//                
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
//                case 0:
//                    VStack(alignment: .leading){
//                        Text(StringResources().galleryDesc_First)
//                            .foregroundColor(.white)
//                        
//                        VStack(alignment: .leading){
//                            Text(StringResources().galleryDesc_Tap).foregroundColor(.white) +
//                            Text("'\(StringResources().yourRecording)'").foregroundColor(.white)
//                                .bold() + 
//                            Text(StringResources().galleryDesc_Second)
//                                .foregroundColor(.white)
//                            
//                        }
//                        .padding(.top, 20)
//                    }.frame(width: 300)
//                        .padding(.bottom, 50)
//                        .padding(.leading, 20)
//                        
//                case 1:
//                    VStack(alignment: .leading){
//                        Text(StringResources().galleryDesc_Tap).foregroundColor(.white) +
//                        Text("'\(StringResources().close)'")
//                            .foregroundColor(.white)
//                            .bold() +
//                        
//                        Text(StringResources().pressClose)
//                            .foregroundColor(.white)
//                    }.frame(width: 300)
//                        .padding(.bottom, 50)
//                    
//                case 2:
//                    //NavigationView{
//                    
//                    VStack(alignment: .leading){
//                        Text(StringResources().galleryDesc_Third)
//                            .foregroundColor(.white)
//                        
//                        VStack(alignment: .leading){
//                            Text(StringResources().swipeRight).foregroundColor(.white)
//                                .bold() + Text(StringResources().galleryDesc_Fourth)
//                                .foregroundColor(.white)
//                            
//                            
//                        }.padding(.top, 20)
//                        
//                    }.frame(width: 300)
//                        .padding(.bottom, 50)
//                        .padding(.leading, 20)
//                        .onAppear{
//                            count = 2
//                        }
//                default:
//                    Text("")
//                }
//                
//                //.padding(.bottom, 270)
//                //Spacer()
//                
//                //                Button(action: {
//                //                    galleryViewModel.isExpanded = false
//                //                }){
//                //                    Text("This Button")
//                //                }
//                //                VStack{
//                //                    CloseButton()
//                //                }
//                //                .onTapGesture {
//                //                    galleryViewModel.isExpanded = false
//                //                    galleryViewModel.isClosed = true
//                //                }
//                //di main nnti hapus height sama ganti padding .bottom jdi 90
//                
//                //di main nanti enable scrollviewnya
//                //di main nanti hapus Spacer() di bawah width: 300
//                //}
//                
//                
//                
//                
//            }
//            .padding(.top, 40)
//        }
//        .gesture(
//            DragGesture()
//                .onChanged { gesture in
//                    if gesture.translation.width > 200 {
//                        
//                        self.presentationMode.wrappedValue.dismiss()
//                        self.isMainPagePresented = true
//
//                    }
//                }
//        )
//        .background(
//            NavigationLink(
//                
//                destination:
//                    OnBoardingInterpretation(viewModel: OnboardingViewModel()),
//                isActive: $isMainPagePresented
//            ) {
//                EmptyView()
//            }
//        )
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
//    }
//        
//}
//    }
//
//
//#Preview {
//    GalleryView(viewModel: OnboardingViewModel())
//}
