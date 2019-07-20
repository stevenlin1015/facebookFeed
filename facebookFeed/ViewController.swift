//
//  ViewController.swift
//  facebookFeed
//
//  Created by Steven on 2019/7/12.
//  Copyright © 2019 Steven. All rights reserved.
//

import UIKit

let cellId = "cellId"

class Post {
    var name: String?
    var statusText: String?
    var profileImageName: String?
    var statusImageName: String?
    var numLikes: Int?
    var numComments: Int?
}

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let postSteven = Post()
        postSteven.name = "Steven Lin"
        postSteven.statusText = "Meanwhile, Beast turned to the dark side."
        postSteven.profileImageName = "profile"
        postSteven.statusImageName = "DSC01887"
        postSteven.numLikes = 400
        postSteven.numComments = 123

        
        let postMark = Post()
        postMark.name = "Mark Zuckerberg"
        postMark.statusText = "“The future is private,” Zuckerberg told the crowd,\nnoting that Facebook’s most dominant vision over the last decade was to build global communities that would bring the world together, for better or worse. “Over time, I believe that a private social platform will be even more important to our lives than our digital town squares.\nSo today, we’re going to start talking about what this could look like as a product, what it means to have your social experience be more intimate, and how we need to change the way we run this company in order to build this.”"
        postMark.profileImageName = "markprofileimage"
        postMark.statusImageName = "markstatusimage"
        postMark.numLikes = 1000
        postMark.numComments = 55
        
        let postSteveJobs = Post()
        postSteveJobs.name = "Steve Jobs"
        postSteveJobs.statusText = "Well, necessity...There were time sharing computers available and there was a time sharing company in Mountain View that we could get free time on, but we needed a terminal, and we couldn't afford one...So what an Apple I was, was really an extension of this terminal putting a microprocessor on the back end...And we really built it for ourselves because we couldn't afford to buy anything."
        postSteveJobs.profileImageName = "stevejobsprofileimage"
        postSteveJobs.statusImageName = "stevejobsstatusimage"
        postSteveJobs.numLikes = 333
        postSteveJobs.numComments = 22
        
        posts.append(postSteven)
        posts.append(postMark)
        posts.append(postSteveJobs)
        
        navigationItem.title = "Facebook Feed"
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.alwaysBounceVertical = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
        feedCell.post = posts[indexPath.item]
        
        return feedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let statusText = posts[indexPath.item].statusText {
            
            //calculate dynamic textView height according to string context.
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], context: nil)
            
            let knownHeight: CGFloat = 8 + 44 + 8 + 8 + 250 + 8 + 24 + 8 + 1 + 44 + 8
            return CGSize(width: view.frame.width, height: rect.height + knownHeight + 16 )
        }
        
        return CGSize(width: view.frame.width, height: 460)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView.collectionViewLayout.invalidateLayout()
    }

}

class FeedCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            
            if let name = post?.name {
                let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
                attributedText.append(NSAttributedString(string: "\nDecember 18 • San Francisco • ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 155, green: 161, blue: 171)]))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                
                attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.string.count))
                
                //加地球圖片
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "global")
                attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                attributedText.append(NSAttributedString(attachment: attachment))
                
                nameLabel.attributedText = attributedText
            }
            
            if let statusText = post?.statusText {
                statusTextView.text = statusText
            }
            
            if let profileImageName = post?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
            }
            
            if let statusImageName = post?.statusImageName {
                statusImageView.image = UIImage(named: statusImageName)
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        //textView.text = "Meanwhile, Beast turned to the dark side."
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DSC01887")
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.text = "488 Likes   10.7K Comments"
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    //post和按鈕的分隔線(用UIView做)
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        return view
    }()
    
    //buttons
    let likeButton = FeedCell.setupButton(labelName: "Like", imageName: "like@44px")
    let commentButton = FeedCell.setupButton(labelName: "Comment", imageName: "comment@44px")
    let shareButton = FeedCell.setupButton(labelName: "Share", imageName: "share@44px")
    
    static func setupButton(labelName: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(labelName, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setImage(UIImage(named: imageName), for: .normal)
        
        button.contentHorizontalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 22)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        return button
    }
    
    func setupView() {
        backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        addSubview(dividerLineView)
        
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)

        
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: statusTextView)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: statusImageView)
        addConstraintsWithFormat(format: "H:|-12-[v0]-8-|", views: likesCommentsLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: dividerLineView)
        
        addConstraintsWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
        
        
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-8-[v1]-8-[v2(250)]-8-[v3(24)]-8-[v4(1)][v5(44)]-2-|", views: profileImageView, statusTextView, statusImageView, likesCommentsLabel,dividerLineView, likeButton)
        
        addConstraintsWithFormat(format: "V:[v0(44)]-2-|", views: commentButton)
        addConstraintsWithFormat(format: "V:[v0(44)]-2-|", views: shareButton)
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
