//: A UIKit based Playground for presenting user interface
  
import SwiftUI
import PlaygroundSupport
import Darwin

struct ContentView: View {

  private var controller = StoryController()
  @State private var dialogTxt = ""
  @State private var backgroungImg: String = "dolomites.jpeg"
  @State private var characterImg: String = "giau.jpeg"
    
  var body: some View {
    ZStack {
      Image(uiImage: UIImage(named: backgroungImg)!)
            .resizable()
            .frame(width: 700, height: 700)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
      Text("\(dialogTxt)")
          .bold()
          .kerning(1.5)
          .multilineTextAlignment(.center)
          .lineSpacing(4.0)
          .font(.footnote)
          .onAppear {
            controller.animateText { text in
              dialogTxt = text
          }
      }
      Button("Next") {
        controller.nextDialog()
        backgroungImg = controller.currentItem.sceneImg
      }
    }
  }
}

// Show the view
PlaygroundPage.current.setLiveView(
    ContentView().frame(width: 700, height: 700)
)
