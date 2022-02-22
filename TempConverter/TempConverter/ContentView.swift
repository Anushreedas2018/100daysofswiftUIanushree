//
//  ContentView.swift
//  TempConverter
//
//  Created by Anushree Das on 19/06/21.
//

import SwiftUI
struct ContentView: View {
    
    @State private var tempAmount = 0.0
    @State private var tempFrom = "Celsius"
    @State private var tempTo = "Celsius"
//    @State private var tempConverted = 0.0
    
    
    let selectUnit = ["Celcius", "Fahrenheit", "Kelvin"]
    let convertUnit = ["Celcius", "Fahrenheit", "Kelvin"]
    
    var tempConverted: Double{
        let tempConvert = Double(tempAmount)

        let tempC2F = tempConvert * 1.8 + 32
        let tempC2K = tempConvert + 273.15
        
        let tempF2C = (tempConvert - 32)/1.8
        let tempF2K = (tempConvert - 32)/1.8 + 273.15
        
        let tempK2C = tempConvert - 273.15
        let tempK2F = (tempConvert - 273.15)*1.8 + 32
        
        if tempFrom == "Celcius"  && tempTo == "Fahrenheit"{
            return tempC2F
        } else if tempFrom == "Celcius" && tempTo == "Kelvin"{
            return tempC2K
        } else if tempFrom == "Fahrenheit" && tempTo == "Celcius"{
            return tempF2C
        } else if tempFrom == "Fahrenheit" && tempTo == "Kelvin"{
            return tempF2K
        } else if tempFrom == "Kelvin" && tempTo == "Celcius"{
            return tempK2C
        } else if tempFrom == "Kelvin" && tempTo == "Fahrenheit"{
            return tempK2F}
        
          else
    
          {return tempConvert}
    }
    
var body: some View {
        
        NavigationView{
            Form{
                Section{
                    TextField("Temperature to convert", value: $tempAmount, format: .number)
                        .keyboardType(.numberPad)
                    Picker("Select the unit to convert from", selection: $tempFrom){
                        
                        ForEach(selectUnit, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                }
            header: {
                Text("Temperature to convert from")
            }
                
               
                
                Section{
                    Picker("Select the unit to convert to", selection: $tempTo){
                        ForEach(convertUnit, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text(tempConverted, format: .number)
                    
                }
            header: {
                Text("Temperature Converted to")
            }
                

        
            }
            .navigationBarTitle("TempConverter", displayMode: .inline)
        }
        
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
