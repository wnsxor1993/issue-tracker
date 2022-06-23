//
//  CommentView.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/21.
//

import UIKit

final class CommentView: UIView {

    let commentTextHolder = "코멘트는 여기에 작성해주세요"

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.text = "제목"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .smallRegular
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private(set) lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .smallRegular
        textView.textColor = .issueTrackerGray3
        textView.text = commentTextHolder
        textView.translatesAutoresizingMaskIntoConstraints = false

        return textView
    }()

    private let heightDividedLine = DividedLineView()
    private let widthDividedLine = DividedLineView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension CommentView {

    func setConstraints() {
        let leftSideLeadingConstant: CGFloat = 16
        let upperSectionTopConstant: CGFloat = 11
        let upperSectionHeightConstant: CGFloat = 22

        let tenConstant: CGFloat = 10
        let titleWidthConstant: CGFloat = 30
        let heightLineWidthConstant: CGFloat = 2
        let heightLineLeadingConstant: CGFloat = 17
        let widthLineHeightConstant: CGFloat = 1
        let widthLineLeadingConstant: CGFloat = 20

        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubViews(titleLabel, titleTextField, commentTextView, heightDividedLine, widthDividedLine)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leftSideLeadingConstant),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: upperSectionTopConstant),
            titleLabel.widthAnchor.constraint(equalToConstant: titleWidthConstant),
            titleLabel.heightAnchor.constraint(equalToConstant: upperSectionHeightConstant),

            heightDividedLine.widthAnchor.constraint(equalToConstant: heightLineWidthConstant),
            heightDividedLine.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: heightLineLeadingConstant),
            heightDividedLine.topAnchor.constraint(equalTo: self.topAnchor, constant: upperSectionTopConstant),
            heightDividedLine.heightAnchor.constraint(equalToConstant: upperSectionHeightConstant),

            titleTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: upperSectionTopConstant),
            titleTextField.heightAnchor.constraint(equalToConstant: upperSectionHeightConstant),
            titleTextField.leadingAnchor.constraint(equalTo: heightDividedLine.trailingAnchor, constant: tenConstant),
            titleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            widthDividedLine.heightAnchor.constraint(equalToConstant: widthLineHeightConstant),
            widthDividedLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: widthLineLeadingConstant),
            widthDividedLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            widthDividedLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: tenConstant),

            commentTextView.topAnchor.constraint(equalTo: widthDividedLine.bottomAnchor),
            commentTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            commentTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leftSideLeadingConstant),
            commentTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
