//
//  CaptureView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/31/23.
//

import SwiftUI
import PhotosUI

struct CaptureView: View {
    
    @State var libraryIsShowing: Bool = false
    @State var manualCaptureIsShowing: Bool = false
    @State var recentPhotos: [UIImage] = [UIImage]()
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                InformationCard()
                    .padding()
                HStack {
                    Text("Capture")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                }
                HStack{
                    Spacer()
                    PhotosPicker(
                        selection: $selectedItem, 
                        matching: .images,
                        photoLibrary: .shared()) {
                            VStack {
                                Image(systemName: "photo.on.rectangle")
                                Text("Library")
                            }
                        }
                        .onChange(of: selectedItem) { newItem in
                            Task {
                                // Retrieve selected asset in the form of Data
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                }
                            }
                        }
                    Spacer()
                    Button(action: {
                        print(selectedImageData)
                    }, label: {
                        VStack {
                            Image(systemName: "camera")
                            Text("Camera")
                        }
                        .padding()
                    })
                    .background {
                        Circle()
                            .fill(.myGray)
                            .aspectRatio(contentMode: .fill)
                    }
                    Spacer()
                    Button(action: {
                        print("manual")
                        manualCaptureIsShowing = true
                    }, label: {
                        VStack {
                            Image(systemName: "plus")
                            Text("Manual")
                        }
                    })
                    Spacer()
                }
                .padding()
                HStack {
                    Text("Library")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(recentPhotos, id: \.self) { photo in
                            Image(uiImage: photo)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200)
                                .cornerRadius(10)
                        }
                        Button(action: {
                            print("action")
                        }, label: {
                            Text("See all")
                        })
                        .frame(width: 200, height: 200)
                        .buttonStyle(.bordered)
                    }
                }
                .frame(height: 200)
                .padding(.horizontal)
                .onAppear {
                    fetchRecentPhotos(completion: { photos in
                        if let photos = photos {
                            // Do something with the array of recent photos
                            recentPhotos = photos
                            print("Recent photos: \(photos)")
                        } else {
                            print("Failed to fetch recent photos.")
                        }
                    })
                }
                Spacer()
            }
            .navigationTitle("Home")
            .sheet(isPresented: $manualCaptureIsShowing, onDismiss: {
                manualCaptureIsShowing = false
            }) {
                ManualCaptureView()
            }
        }
    }
    
    func fetchRecentPhotos(completion: @escaping ([UIImage]?) -> Void) {
        var recentPhotos: [UIImage] = []
        
        // Create a PHFetchOptions instance to specify the sorting order
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        // Fetch the user's photo library
        let result = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        // Fetch the first 10 assets (photos)
        let endIndex = min(result.count, 10)
        for i in 0..<endIndex {
            let asset = result.object(at: i)
            
            // Request image representation for the asset
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            
            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: options) { image, _ in
                if let image = image {
                    recentPhotos.append(image)
                }
            }
        }
        
        // Call the completion handler with the array of recent photos
        completion(recentPhotos)
    }
}

#Preview {
    CaptureView(recentPhotos: [])
}
