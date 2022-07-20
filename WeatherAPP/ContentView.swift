//
//  ContentView.swift
//  WeatherAPP
//
//  Created by Zuo.Kevin on 2022/7/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        VStack {
            LoadingView(isShowing: self.$vm.isShowing) {
                VStack(alignment: .center, spacing: 10){
                    AsyncImage(url: URL(string: vm.weather.imageSuffix))
                        .clipShape(Circle())
                        .frame(width: 80, height: 80)
                    Text(vm.data.name)
                        .font(.title)
                    Text(vm.data.main.celsius)
                        .font(.system(size: 60, weight: .bold))
                    Text(vm.weather.description)
                        .font(.headline)
                    HStack {
                        Text(vm.data.main.max)
                            .font(.subheadline)
                        Text(vm.data.main.min)
                            .font(.subheadline)
                    }
                }
                .padding(.top,80)
                .frame(width: ScreenW)
                .onAppear {
                    vm.getWeatherData(cityName: vm.selectedCity)
                }
            }
            List {
                ForEach(vm.cities, id: \.self) { item in
                    Button(action: {
                        vm.selectedCity = item
                        vm.getWeatherData(cityName: vm.selectedCity)
                    }) {
                        Text(item)
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                
                VStack {
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)
                
            }
        }
    }
    
}
