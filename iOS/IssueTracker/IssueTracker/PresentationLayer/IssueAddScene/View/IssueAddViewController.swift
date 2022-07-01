//
//  IssueAddViewController.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/21.
//

import UIKit

final class IssueAddViewController: UIViewController {

    private var commentView = CommentContainerView()
    private var listView = ListContainerView()

    private var dataSource: TableViewDataSource<IssueAddListEntity, ListCell>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setConstraints()
        setInnerPropertyDelegate()
        setDatasource()
        setObservingKeyboardNotification()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

private extension IssueAddViewController {

    func setNavigationBar() {
        let rightBarButton = UIBarButtonItem(title: "저장 +", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = rightBarButton
        self.navigationController?.navigationBar.backgroundColor = .white
    }

    func setConstraints() {
        let commentViewHeightRatio = 0.7

        self.view.addSubViews(commentView, listView)

        NSLayoutConstraint.activate([
            commentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            commentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            commentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            commentView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: commentViewHeightRatio),

            listView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            listView.topAnchor.constraint(equalTo: commentView.bottomAnchor),
            listView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setInnerPropertyDelegate() {
        self.listView.setDelegate(to: self)
        self.commentView.setDelegate(to: self)
    }

    func setDatasource() {
        let label = IssueAddListEntity(title: "레이블", selectedValue: nil)
        let milestone = IssueAddListEntity(title: "마일스톤", selectedValue: nil)
        let assignee = IssueAddListEntity(title: "담당자", selectedValue: nil)
        let models = [label, milestone, assignee]

        let dataSource = TableViewDataSource(models, reuseIdentifier: ListCell.cellIdentifier, cellConfigurator: { (model: IssueAddListEntity, cell: ListCell) in
            cell.configureCellText(title: model.title, value: model.selectedValue)
        })

        self.dataSource = dataSource
        listView.listTableView.dataSource = dataSource
    }

    func setDataBinding() {
        // MARK: TO BE IMPLEMENTED WITH VIEWMODEL
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
        self.navigationItem.rightBarButtonItem?.title = "입력 취소"
        self.navigationItem.rightBarButtonItem?.action = #selector(dismissKeyboard)
    }

    @objc
    func hideKeyboard() {
        self.navigationItem.rightBarButtonItem?.title = "저장 +"
        self.navigationItem.rightBarButtonItem?.action = #selector(saveIssue)
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
        guard textView.textColor == .issueTrackerGray3 else { return }

        textView.text = nil
        textView.textColor = .black
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        guard textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        textView.text = commentView.commentTextHolder
        textView.textColor = .issueTrackerGray3
    }
}

extension IssueAddViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableCellHeight: CGFloat = 44

        return tableCellHeight
    }
}
