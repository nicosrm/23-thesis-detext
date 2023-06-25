//
//  AboutView.swift
//  iOS
//
//  Created by Venkat on 20/9/20.
//

import SwiftUI

struct AboutView: View {
    
    @Environment(\.dismiss) var dismiss
        
    var body: some View {
        NavigationView {
            List {
                Section(header: Text(appVersion())) {
                    Text("Made, with ❤️, by [Venkat](https://venkatasg.net). Inspired by Detexify, I wanted to make a native iOS app for translating hand-drawn symbols to their corresponding LaTeX commands that was fast, efficient, and lightweight.")
                }
                
                //Feedback
                Section(header:Text("Feedback")) {
                    Text("You can [email me](mailto:venkat@venkatasg.net) or contact me on [Twitter](https://twitter.com/_venkatasg) for support, to report any bugs, or to suggest new features for the app.")
                    HStack {
                        Image(systemName: "heart.circle.fill")
                            .foregroundColor(.pink)
                            .accessibility(label: Text("Please Rate & Review DeTeXt"))
                        Link("Rate and Review on App Store", destination: URL(string: "itms-apps://itunes.apple.com/app/id1531906207?action=write-review")!)
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.blue)
                    }
                }
                
                // Info
                Section(header: Text("How it works")) {
                    Text("DeTeXt uses a ") + Text("[mobilenet_v2](https://pytorch.org/hub/pytorch_vision_mobilenet_v2/)").font(.system(.body, design: .monospaced)) + Text(" PyTorch model trained on the Detexify training data, which was then translated to CoreML using ") +
                        Text("[coremltools](https://coremltools.readme.io)").font(.system(.body, design: .monospaced)) +
                        Text(".\n\nThe symbol images are generated by converting PDF files containing each symbol (made with LaTeX) to SVG files.\n\nThe source code for DeTeXt is available [on GitHub](https://github.com/venkatasg/DeTeXt) under the MIT License.")
                }

                
                // Credits
                Section(header: Text("Credits")) {
                    Text("Thanks to Daniel Kirsch and the team at [Detexify](http://detexify.kirelabs.org) for their cool open-source web app that inspired me to make DeTeXt, and for providing the training data and prompt responses to my questions.\n\n") +
                    Text("Thanks to [Will Bishop](https://willbish.com) for helping me figure out a tricky problem I had with the PencilKit APIs.\n\n") +
                    Text("A big thanks to [Hans](https://twitter.com/SherlockHans) for beta testing new features and giving valuable feedback.\n\n") +
                    Text("Finally a big thanks to all the folks on the [NetNewsWire](https://ranchero.com/netnewswire/) Slack for being supportive and inspiring me to build my own iOS app.")
                }
                
                //Privacy
                Section(header: Text("Privacy")) {
                        Text("DeTeXt does not collect or store any personal data or information. All processing of drawings to find the corresponding symbol happens on your device.\n\n") +
                        Text("DeTeXt does not display any advertisements, use any trackers or analytics, or send any data to any server.")
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("About")
            .navigationBarItems(leading: Button(action: {
                self.dismiss()
            }) {
                    Text("Done")
                        .accessibility(label: Text("Done"))
                }
                .buttonStyle(.borderless)
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct AboutView_Previews: PreviewProvider {

    static var previews: some View {
        AboutView()
    }
}
