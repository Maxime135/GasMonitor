//
//  ConsumptionView.swift
//  GasMonitor
//
//  Created by Maxime BOULANGER on 19/03/2023.
//

import SwiftUI

struct ConsumptionView: View {
    
    @EnvironmentObject var model:CarModel

    
    var body: some View {
        Text("ConsumptionView")
    }
}

struct ConsumptionView_Previews: PreviewProvider {
    static var previews: some View {
        ConsumptionView()
            .environmentObject(CarModel())
    }
}
