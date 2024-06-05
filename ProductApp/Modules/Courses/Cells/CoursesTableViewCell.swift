//
//  CoursesTableViewCell.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 03.06.2024.
//

import UIKit
import SnapKit

final class CoursesTableViewCell: UITableViewCell {

    // MARK: - UI
    private lazy var courseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var courseTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var courseInstructorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var courseDurationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var courseAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.backgroundColor = .systemBackground
        [courseImageView, courseTitleLabel, courseInstructorLabel,
         courseDurationLabel, courseAmountLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        courseImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(80)
            make.bottom.lessThanOrEqualToSuperview().offset(-16)
        }
        
        courseTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(courseImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        courseInstructorLabel.snp.makeConstraints { make in
            make.top.equalTo(courseTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(courseImageView.snp.trailing).offset(16)
        }
        
        courseDurationLabel.snp.makeConstraints { make in
            make.top.equalTo(courseInstructorLabel.snp.bottom).offset(16)
            make.leading.equalTo(courseImageView.snp.trailing).offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        courseAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(courseInstructorLabel.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Configure
    public func configure(viewModel: Courses.ViewModel) {
        courseTitleLabel.text = viewModel.title
        courseImageView.image = UIImage(named: viewModel.image)
        courseInstructorLabel.text = viewModel.instructor
        courseDurationLabel.text = viewModel.duration
        courseAmountLabel.text = "\(viewModel.amount)₸"
    }

}
