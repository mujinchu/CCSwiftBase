//
//  CCActionSheetAlertView.swift
//  CCSwiftBase
//
//  Created by cui on 2023/12/7.
//

import Foundation
import UIKit

class CCActionSheetAlertView<T: CCEnumProtocol>: UIView, UITableViewDelegate, UITableViewDataSource {
    // MARK: - present
    static func present(with actions: [T], title: String? = nil, text: String? = nil, completion: @escaping CCCompleteHandler<T>) {
        let alertView = CCActionSheetAlertView(actions: actions, title: title, text: text, completion: completion)
//        shared.showPresentView(alertView, isCover: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            alertView.show()
        }
    }
    
    // MARK: - lazy view
    lazy var contentView = UIView().backgroundColor(.white)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.separatorInset = .zero
        tableView.separatorColor = UIColor(hex: 0xf0f0f0)
        
        tableView.cc.register(with: CCActionSheetAlertTableViewCell.self)
        
        return tableView
    }()
    
    lazy var lineView = UIView().backgroundColor(0xf0f0f0)
    
    lazy var cancelButton = UIButton(type: .custom).title("取消").textColor(0x333333)
    
    // MARK: - info
    enum alertSection {
        case title_section
        case desc_section
        case action_section
    }
    
    private var actions: [T] = []
    private var completeHandler: CCCompleteHandler<T>?
    private var title: String = ""
    private var descText: String = ""
    private var sections: [alertSection] = []
    
    init(frame: CGRect = .zero, actions: [T], title: String?, text: String?, completion: @escaping CCCompleteHandler<T>) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0, alpha: 0.4)
        self.alpha = 0
        
        self.actions = actions
        self.title = title ?? ""
        self.descText = text ?? ""
        self.completeHandler = completion
        
        initSubviews()
        
        sections.removeAll()
        if !self.title.isEmpty {
            sections.append(.title_section)
        }
        if !self.descText.isEmpty {
            sections.append(.desc_section)
        }
        sections.append(.action_section)
        
        tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        cancelButton.action { [weak self] in
            guard let `self` = self else { return }
            self.dismiss()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            let height = tableView.contentSize.height
            tableView.cc.height = height
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch
            let point = t.location(in: self)
            if !contentView.frame.contains(point) {
                dismiss()
            }
        }
    }
    
    deinit {
        tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UITableView delegate & dataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = sections[section]
        switch item {
        
        case .title_section:
            return 1
        case .desc_section:
            return 1
        case .action_section:
            return actions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section]
        let cell: CCActionSheetAlertTableViewCell = tableView.cc.dequeueReusableCell()
//        switch item {
//        case .title_section:
//            cell.setText(title, font: UIFont.cc.)
//            break
//        case .desc_section:
//            cell.setText(descText, font: .font(13))
//            break
//        case .action_section:
//            let action = actions[indexPath.row]
//            cell.setText(action.description)
//            break
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard sections[indexPath.section] == .action_section else { return }
        let action = actions[indexPath.row]
        guard let completeHandler = completeHandler else { return }
        completeHandler(action)
        dismiss()
    }
}

extension CCActionSheetAlertView {
    private func show() {
//        contentView.snp.remakeConstraints { make in
//            make.left.right.bottom.equalToSuperview()
//        }
//        UIView.animate(withDuration: 0.25) {
//            self.alpha = 1
//            self.layoutIfNeeded()
//        } completion: { _ in }
    }
    
    private func dismiss() {
//        contentView.snp.remakeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(self.snp.bottom).offset(0)
//        }
//        UIView.animate(withDuration: 0.25) {
//            self.alpha = 0
//            self.layoutIfNeeded()
//        } completion: { _ in
//            self.removeFromSuperview()
//        }
    }
}

extension CCActionSheetAlertView {
    private func initSubviews() {
        addSubview(contentView)
        contentView.addSubview(tableView)
        contentView.addSubview(lineView)
        contentView.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            
        ])
//        tableView.snp.makeConstraints { make in
//            make.left.top.right.equalToSuperview()
//            make.height.equalTo(0)
//        }
//        
//        lineView.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(tableView.snp.bottom).offset(0)
//            make.height.equalTo(6)
//        }
//        
//        cancelButton.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(lineView.snp.bottom).offset(0)
//            make.height.equalTo(60)
//            make.bottom.equalToSuperview().offset(-SAFE_BOTTOM)
//        }
        
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

class CCActionSheetAlertTableViewCell: UITableViewCell {
    lazy var titleLabel = UILabel().numberOfLines(0).textAlignment(.center).textColor(0x333333)
    
    func setText(_ text: String?, font: UIFont = UIFont.systemFont(ofSize: 17)) {
        titleLabel.text = text
        titleLabel.font = font
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
