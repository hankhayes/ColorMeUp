//
//  CaptureView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/31/23.
//

import SwiftUI
import PhotosUI

struct CaptureView: View {
    @State var manualCaptureIsShowing: Bool = false
    @State var showAlert: Bool = false
    @State var recentPhotos: [UIImage] = [UIImage]()
    @State var alertIsPresented: Bool = false
    
    // Library scroller selection
    @State private var didSelectImageFromLibraryScroller: Bool = false
    
    // Library selction
    @State var libraryIsShowing: Bool = false
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var didSelectImageFromLibrary: Bool = false
    @State private var selectedLibraryImage: UIImage = UIImage()
    
    // Camera selection
    @State var takenImage: UIImage = UIImage()
    @State var didUseImageFromCamera: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    InstructionsView()
                } label: {
                    InformationCard(title: "Quick Start", info: "Click one of the options below to capture a new color. You can select a color from a photo, take a new photo, or add a color manually!", readMore: true)
                        .padding()
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                }
                .buttonStyle(.plain)
                HStack {
                    Text("Capture")
                        .font(.title)
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
                                    selectedLibraryImage = UIImage(data: data)!
                                    didSelectImageFromLibrary = true
                                }
                            }
                        }
                    Spacer()
                    NavigationLink {
                        CameraView(takenImage: $takenImage, didUseImage: $didUseImageFromCamera)
                            .toolbar(.hidden)
                    } label: {
                        VStack {
                            Image(systemName: "camera")
                            Text("Camera")
                        }
                        .padding()
                    }
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
                        .font(.title)
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
                                .onTapGesture {
                                    selectedLibraryImage = photo
                                    didSelectImageFromLibrary = true
                                }
                        }
                        PhotosPicker(
                            selection: $selectedItem,
                            matching: .images,
                            photoLibrary: .shared()) {
                                VStack {
                                    Text("See all")
                                }
                            }
                            .onChange(of: selectedItem) { newItem in
                                Task {
                                    // Retrieve selected asset in the form of Data
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        selectedImageData = data
                                        selectedLibraryImage = UIImage(data: data)!
                                        didSelectImageFromLibrary = true
                                    }
                                }
                            }
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
            .sheet(isPresented: $manualCaptureIsShowing, onDismiss: {
                manualCaptureIsShowing = false
                if showAlert {
                    alertIsPresented = true
                    showAlert = false
                }
            }) {
                ManualCaptureView(showAlert: $showAlert, manualCaptureIsShowing: $manualCaptureIsShowing)
                    .presentationDetents([.large])
                    .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            .sheet(isPresented: $didUseImageFromCamera, onDismiss: {
                didUseImageFromCamera = false
                if showAlert {
                    alertIsPresented = true
                    showAlert = false
                }
                didUseImageFromCamera = false
            }, content: {
                GetColorFromCameraImage(takenImage: $takenImage, showAlert: $showAlert, didUseImagefromCamera: $didUseImageFromCamera)
            })
            .sheet(isPresented: $didSelectImageFromLibrary, onDismiss: {
                if showAlert {
                    alertIsPresented = true
                    showAlert = false
                }
                didSelectImageFromLibrary = false
            }, content: {
                GetColorFromImageView(takenImage: $selectedLibraryImage, showAlert: $showAlert, didSelectImageFromLibrary: $didSelectImageFromLibrary)
            })
            .alert(isPresented: $alertIsPresented) {
                Alert(
                    title: Text("Color Added"),
                    message: Text("You have successfully added a color to your collection."),
                    dismissButton: .default(Text("OK")) {
                        alertIsPresented = false
                    }
                )
            }
            .navigationTitle("Home")
            .ignoresSafeArea(.keyboard, edges: .bottom)
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
            
            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 1000, height: 1000), contentMode: .aspectFit, options: options) { image, _ in
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
