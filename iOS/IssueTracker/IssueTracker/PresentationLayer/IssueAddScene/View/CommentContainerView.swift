//
//  CommentView.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/21.
//

import UIKit

final class CommentContainerView: UIView {

    let commentTextHolder = "코멘트는 여기에 작성해주세요"

    private(set) var commentTitleView = CommentTitleContainerView()

    private(set) lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .smallRegular
        textView.textColor = .issueTrackerGray3
        textView.text = commentTextHolder
        textView.translatesAutoresizingMaskIntoConstraints = false

        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func setDelegate(to viewController: UIViewController) {
        guard let delegateVC = viewController as? UITextViewDelegate else { return }

        self.commentTitleView.setDelegate(to: viewController)
        self.commentTextView.delegate = delegateVC
    }
}

private extension CommentContainerView {

    func setConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubViews(commentTitleView, commentTextView)

        NSLayoutConstraint.activate([
            commentTitleView.topAnchor.constraint(equalTo: self.topAnchor),
            commentTitleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            commentTitleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            commentTitleView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),

            commentTextView.topAnchor.constraint(equalTo: commentTitleView.bottomAnchor),
            commentTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            commentTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            commentTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
