//
//  MovieCellNode.swift
//  ghibli-mvvm-texture
//
//  Created by wendy.kurniawan on 22/11/22.
//

import AsyncDisplayKit

internal class MovieCellNode: ASCellNode {
    
    private let bannerNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.style.preferredSize = CGSize(width: 100, height: 80)
        node.contentMode = .scaleAspectFill
        node.placeholderColor = .lightGray
        return node
    }()
    
    private let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.maximumNumberOfLines = 3
        return node
    }()
    private let releaseDateNode = ASTextNode2()
    private let directorNode = ASTextNode2()
    
    internal init(movie: Movie) {
        bannerNode.url = URL(string: movie.movieBanner)
        titleNode.attributedText = .title(movie.title)
        releaseDateNode.attributedText = .paragraph(movie.releaseDate)
        directorNode.attributedText = .paragraph(movie.director)
        super.init()
        
        automaticallyManagesSubnodes = true
        backgroundColor = .white
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let vStackDescription = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 4,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                titleNode,
                directorNode,
                releaseDateNode
            ]
        )
        vStackDescription.style.flexShrink = 1
        
        let hStackMain = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 8,
            justifyContent: .start,
            alignItems: .center,
            children: [
                bannerNode,
                vStackDescription
            ]
        )
        
        let insetMain = ASInsetLayoutSpec(
            insets: UIEdgeInsets(
                top: 10,
                left: 6,
                bottom: 10,
                right: 6
            ),
            child: hStackMain
        )
        
        return insetMain
    }
}
