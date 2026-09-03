//
//  ContentView.swift
//  FishWeightPredictor
//
//  Created by Student-Mac-02 on 2026-09-03.
//
import CoreML
import SwiftUI



struct ContentView: View {
    
    @State private var fishweight = Double(0); //grams
    @State private var fishlength = Int64(0) //millimeters
    @State private var species = String("");
    @State private var alertTitle = String("");
    @State private var alertMessage = String("");
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        return formatter
    }()
    
    var body: some View {
        VStack {
            Image(systemName: "fish")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello fish scientist!")
        }
        .padding()
        
        VStack {
            Text("What species of fish?")
                .font(.headline)
            TextField("Specify species of the fish", text: $species)
                .padding()
            Text("Värdet är \(species)")
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
        VStack {
            Text("Specify length of the fish:")
                .font(.headline)
            
            TextField("Specify length in mms", value: $fishlength, formatter : formatter)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action:calculateFishWeight){
                Label("Calculate", systemImage: "fish")
            }
            
            
            .navigationTitle("Fish Weight Predictor")
                .toolbar {
                    Button ("Calculate", action: calculateFishWeight)
                }
            
        }
        .padding()
        
    }
    

    
    func calculateFishWeight(){
        do {
            let config = MLModelConfiguration()
            let model = try MyTabularRegressor_2(configuration: config)
            let prediction = try model.prediction(species: 1, fishlength : fishlength)
            print("Prediction :\(prediction)")
            fishweight = prediction.fishweight
            print(fishweight)
            alertTitle = "Vi har fått ett resultat!"
            alertMessage = "The fish weighs : \(fishweight) gram"
            
        }catch {
            alertTitle = "Error"
            alertMessage = "Sadly an error was encountered while calculating the fish weight."
        }
    }
}




#Preview {
    ContentView()
}
