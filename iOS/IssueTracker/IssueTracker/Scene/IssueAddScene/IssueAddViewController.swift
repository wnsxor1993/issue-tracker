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

    private var dataSource: TableViewDataSource<AdditionalInfo, ListCell>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setConstraints()
        setInnerPropertyDelegate()
        setDatasource()
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
        self.commentView.commentTextView.delegate = self
    }

    func setDatasource() {
        let label = AdditionalInfo(title: "레이블", value: nil)
        let milestone = AdditionalInfo(title: "마일스톤", value: nil)
        let assignee = AdditionalInfo(title: "담당자", value: nil)
        let models = [label, milestone, assignee]
        issueCardsDidLoad(model: models)
    }

    func issueCardsDidLoad(model: [AdditionalInfo]) {
        let dataSource = TableViewDataSource(model, reuseIdentifier: ListCell.cellIdentifier, cellConfigurator: { (model: AdditionalInfo, cell: ListCell) in
            cell.configureCellText(title: model.title, value: model.value)
        })

        self.dataSource = dataSource
        listView.listTableView.dataSource = dataSource
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

extension IssueAddViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
