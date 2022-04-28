//
//  BottomSheet.swift
//  Sample Apps
//
//  Created by Wind Versi on 25/4/22.
//

import SwiftUI

enum SheetState {
    case collapsed
    case expanded
}

struct PersistentBottomSheet<
    SheetContent, BackContent, TopContent
>: View
where SheetContent: View,
      BackContent: View,
      TopContent: View {
    
    let minSheetHeight: CGFloat
    let sheetHeight: CGFloat
    var moveableSpace: CGFloat {
        sheetHeight - minSheetHeight
    }
        
    @ViewBuilder let sheetContent: SheetContent
    @ViewBuilder let backContent: BackContent
    @ViewBuilder let topContent: TopContent
    
    @Binding var sheetState: SheetState
    @State private var yPos: CGFloat = 0
    @State private var heightTranslation: CGFloat = 0
    @State private var hasAppearedFirstTime: Bool = false

    init(
        minSheetHeight: CGFloat,
        sheetHeight: CGFloat,
        sheetState: Binding<SheetState>,
        @ViewBuilder sheetContent: () -> SheetContent,
        @ViewBuilder backContent: () -> BackContent,
        @ViewBuilder topContent: () -> TopContent
    ) {
        self.minSheetHeight = minSheetHeight
        self.sheetHeight = sheetHeight
        self._sheetState = sheetState
        self.sheetContent = sheetContent()
        self.backContent = backContent()
        self.topContent = topContent()
    }

    var body: some View {
        GeometryReader { geometry in
            
            let maxWidth = geometry.size.width
            let maxHeight = geometry.size.height
            let minYPos = (0 - (sheetHeight / 2)) + maxHeight
            let maxYPos = minYPos + (sheetHeight - minSheetHeight)

            ZStack(alignment: .top) {
                // Layer 1: Content Behind
                backContent
                    .frame(height: moveableSpace + (50 + 10) + topInset + 23)

                // Layer 2: Sheet
                sheetContent
                    .frame(
                        width: maxWidth,
                        height: sheetHeight,
                        alignment: .top
                    )
                    .position(
                        x: maxWidth / 2,
                        y: yPos
                    )
                    // the center of this view is (w/2, h/2) if position is (0, 0)
                    // we modify the center to bottom left corner (w/2, -h/2)
                    .animation(
                        hasAppearedFirstTime ?
                                nil :
                                .interactiveSpring(
                                    response: 0.35,
                                    dampingFraction: 1
                                ),
                        value: yPos
                    )
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // active sheet animation
                                if hasAppearedFirstTime {
                                    hasAppearedFirstTime = false
                                }
                                
                                // move sheet = move its y coordinate pos
                                // negative value - swiping up
                                // positive value - swiping down
                                let newHeight = value.translation.height
                                let amountChange = newHeight - heightTranslation // new value - old value
                                heightTranslation = newHeight // set to new value
                                let newYPos = yPos + amountChange
                                
                                // move beyond its initial y position
                                // new pos > initial pos = sheet going down or up in range
                                if newYPos > minYPos &&
                                    newYPos < minYPos + (sheetHeight - minSheetHeight) {
                                    yPos = newYPos
                                }
                            }
                            .onEnded { value in
                                // reset to prevent accumulation for the next gesture
                                heightTranslation = 0
                                
                                // snap to peek yPos if it reaches the upper threshold
                                let topThreshold = minYPos + (moveableSpace / 2 - 50)
                                
                                if (yPos <= topThreshold) {
                                    yPos = minYPos
                                    sheetState = .expanded
                                } else if (yPos > topThreshold) {
                                    yPos = maxYPos
                                    // ISSUE: changing to collapse doesnt
                                    //        trigger onChange sheet state
                                    sheetState = .collapsed
                                }
                            }
                    )
                    .onAppear {
                        // to prevent animation when sheet is first shown
                        hasAppearedFirstTime = true
                        yPos = sheetState == .expanded ? minYPos : maxYPos
                    }
                
                // Layer 3:
                topContent
                
            } //: ZStack
            .onChange(of: sheetState) { state in
                if state == .expanded {
                    yPos = minYPos
                }
                if state == .collapsed {
                    yPos = maxYPos
                }
            }

        } //: Geometry Reader
        .fillMaxSize()
        .ignoresSafeArea(.container, edges: .all)
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            
            let height = geometry.size.height * 0.7
            
            PersistentBottomSheet(
                minSheetHeight: height * 0.2,
                sheetHeight: height,
                sheetState: .constant(.collapsed),
                sheetContent: {
                    VStack {
                        Text("Content")
                    }
                    .fillMaxSize()
                    .background(Color.white)
                    .cornerRadius(
                        radius: 20,
                        corners: [.topLeft, .topRight]
                    )
                },
                backContent: { Color.black },
                topContent: { }
            )
        }
        .fillMaxSize()
    }
}
