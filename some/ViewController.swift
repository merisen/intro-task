//
//  ViewController.swift
//  some
//
//  Created luna on 18.12.2020.
//

import UIKit

class ViewController: UIViewController {
    let tableView = UITableView()
    let arr = imagesLink.count
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Intro project"
        
        tableView.frame = self.view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
                
        self.view.addSubview(tableView)
    }
    
    @objc func imageTapped(sender: UIImageView) {
        self.present(ImageViewController(), animated:true, completion:nil)
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyCell()
        cell.button.tag = indexPath.row
        cell.previewImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        return cell
    }
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

let linearBar: LinearProgressBar = LinearProgressBar()
let imagesLink: [String] = [
    "https://therightsofnature.org/wp-content/uploads/2018/01/turkey-3048299_1920-1366x550.jpg",
     "https://s3-us-west-2.amazonaws.com/uw-s3-cdn/wp-content/uploads/sites/6/2017/11/04133712/waterfall.jpg",
     "https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5f9cca07d4c42920d4d348c7%2F0x0.jpg",
     "https://www.brinknews.com/wp-content/uploads/2019/09/GettyImages-81794997.jpg",
     "https://www.meissl.com/media/images/8f24db1f/schweiz.jpg",
     "https://www.greenpeace.org/static/planet4-international-stateless/2017/11/GP0STOE2U.jpg",
     "https://horizon-media.s3-eu-west-1.amazonaws.com/s3fs-public/field/image/ecosystem.jpg",
     "https://www.shell.com/energy-and-innovation/new-energies/nature-based-solutions/_jcr_content/pagePromo/image.img.960.jpeg/1554332446421/canopy-header.jpeg",
     "https://pi.tedcdn.com/r/talkstar-assets.s3.amazonaws.com/production/playlists/playlist_398/reconnect_with_nature.jpg?",
     "https://www.visitnsw.com/sites/visitnsw/files/styles/open_graph/public/2019-08/163670-Header.jpg?itok=_gnTGSka",
     "https://www.pbs.org/wnet/nature/files/2019/07/Super-Hummingbirds-2-1280x675.jpg",
     "https://www.hindustantimes.com/rf/image_size_1200x900/HT/p2/2020/07/11/Pictures/topshot-greenland-denmark-nature-environment-climate-glacier_a133ef08-c2f7-11ea-bed6-81066a26d6e8.jpg",
     "https://ntnc.org.np/sites/default/files/styles/slider_1920x1024/public/default_images/default-cover_0.jpg?itok=Tps_3S1F",
     "https://cdn.britannica.com/78/155378-050-838B4322/Himalayas-Nepal.jpg",
     "https://www.visittromso.no/sites/cb_tromso/files/styles/slide_large/public/Nature_travelstyle.jpg?h=46a20b3e&itok=UeguC4sC",
     "https://cdn.the-scientist.com/assets/articleNo/66484/aImg/33769/article-nature-as-medicine-l.png",
     "https://ichef.bbci.co.uk/images/ic/1200x675/p01lymgh.jpg",
     "https://www.visitluxembourg.com/media/cache/562567_cropped_1200_627_70_5d94659242953_nature-and-tours-alfonso-salgueiro.jpg",
     "https://cdn.cnn.com/cnnnext/dam/assets/201009181148-solace-in-nature-top-restricted.jpg",
     "https://www.adobe.com/content/dam/cc/us/en/creative-cloud/photography/discover/nature-photography/desktop/nature_P1_900x420.jpg.img.jpg"
    ]
var tagImage: Int = 0
var imageDownloadState: Bool = true
var isOn = false

class MyCell: UITableViewCell {
    let button = UIButton()
    let previewImage = UIImageView()
    let imageText = UILabel()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        linearBar.frame.origin = CGPoint(x: 0, y: 140);
        self.contentView.addSubview(linearBar)
        
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .allTouchEvents)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        
        self.contentView.addSubview(button)
        let margins = self.layoutMarginsGuide
        
        button.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0).isActive = true
        button.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 16).isActive = true
        button.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0).isActive = true

        previewImage.backgroundColor = .black
        previewImage.translatesAutoresizingMaskIntoConstraints = false
        previewImage.isUserInteractionEnabled = true
        
        self.contentView.addSubview(previewImage)
        
        previewImage.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0).isActive = true
        previewImage.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0).isActive = true
        previewImage.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 0).isActive = true
        previewImage.widthAnchor.constraint(equalToConstant: 40.0).isActive = true

        imageText.text = "Download this image"
        imageText.backgroundColor = .white
        imageText.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(imageText)
        
        imageText.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 50).isActive = true
        imageText.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -50).isActive = true
        imageText.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0).isActive = true
        imageText.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0).isActive = true
    }
    
    @objc func buttonTapped(sender: UIButton) {
        tagImage = sender.tag
        print("tap \(sender.tag)")
        button.setTitle(isOn ? "Stop" : "Start", for: .normal)
        
        if sender.currentTitle == "Start" {
            print("start")
            isOn = true
            imageDownloadState = true
            //self.button.setTitle("Stop", for: .normal)
            linearBar.startAnimation()
            DispatchQueue.background(background: {
                self.previewImage.downloaded(from: "\(imagesLink[sender.tag])")
            }, completion:{
                //self.button.setTitle("Start", for: .normal)
                linearBar.stopAnimation()
            })
        } else if sender.currentTitle == "Stop" {
            print("stop")
            isOn = false
            imageDownloadState = false
            linearBar.startAnimation()
            DispatchQueue.background(background: {
                self.previewImage.downloaded(from: "\(imagesLink[sender.tag])")
            }, completion:{
                //self.button.setTitle("Start", for: .normal)
                linearBar.stopAnimation()
            })
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        if imageDownloadState == true {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            }.resume()
        } else if imageDownloadState == false {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            }.cancel()
        }
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

// MARK: ImageViewController: UIViewController

class ImageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView()
        let myImageView: UIImageView = UIImageView()
        
        myImageView.contentMode = UIView.ContentMode.scaleAspectFit
        myImageView.frame.size.width = 600
        myImageView.frame.size.height = 1600
        myImageView.center = self.view.center
        
        myImageView.downloaded(from: "\(imagesLink[tagImage])")
        
        view.backgroundColor = .white
        view.addSubview(myImageView)
        
        self.view = view
    }
}

extension DispatchQueue {
    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
}
