//
//  IssueAddViewController.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/21.
//

import UIKit

final class IssueAddViewController: UIViewController {

    private var commentView = CommentView()
    private var listView = ListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setConstraints()
        setInnerPropertyDelegate()
        setObservingKeyboardNotification()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

private extension IssueAddViewController {

    func setNavigationBar() {
        let rightBarButton = UIBarButtonItem(title: "저장 +", style: .plain, target: self, action: nil)
        self.navigationController?.navigationItem.rightBarButtonItem = rightBarButton
    }

    func setConstraints() {
        self.view.addSubViews(commentView, listView)

        NSLayoutConstraint.activate([
            commentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            commentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            commentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            commentView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7),

            listView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            listView.topAnchor.constraint(equalTo: commentView.bottomAnchor),
            listView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    func setInnerPropertyDelegate() {
        self.listView.listTableView.delegate = self
        self.listView.listTableView.dataSource = self
        self.commentView.commentTextView.delegate = self
    }
}

// MARK: Navigation Button with Keyboard
private extension IssueAddViewController {

    func setObservingKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc
    func showKeyboard() {
        self.navigationController?.navigationItem.rightBarButtonItem?.title = "입력 취소"
        self.navigationController?.navigationItem.rightBarButtonItem?.action = #selector(dismissKeyboard)
    }

    @objc
    func hideKeyboard() {
        self.navigationController?.navigationItem.rightBarButtonItem?.title = "저장 +"
        self.navigationController?.navigationItem.rightBarButtonItem?.action = #selector(saveIssue)
    }

    @objc
    func dismissKeyboard() {
        self.view.endEditing(true)
    }

    @objc
    func saveIssue() {

    }
}

extension IssueAddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.text == commentView.commentTextHolder else { return }

        textView.text = nil
        textView.textColor = .black
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        guard textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        textView.text = commentView.commentTextHolder
        textView.textColor = UIColor(red: 0.529, green: 0.529, blue: 0.553, alpha: 1)
    }
}

extension IssueAddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.cellIdentifier) as? ListCell else { return UITableViewCell()}

        cell.configureCellText(title: "AAA", value: "nothing")
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
