//
//  CourseDetailsViewController.swift
//  ProductApp
//
//  Created by Ерасыл Еркин on 05.06.2024.
//

import UIKit
import SnapKit

final class CourseDetailsViewController: UIViewController {

    // MARK: - Deps
    private let courseData: Courses.ViewModel
    
    init(courseData: Courses.ViewModel) {
        self.courseData = courseData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private lazy var courseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: courseData.image)
        return imageView
    }()
    
    private lazy var courseTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 2
        label.text = courseData.title
        return label
    }()
    
    private lazy var courseInstructorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = courseData.instructor
        return label
    }()
    
    private lazy var courseDurationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = courseData.duration
        return label
    }()
    
    private lazy var courseAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "\(courseData.amount)₸"
        return label
    }()
    
    private lazy var courseDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = courseData.description
        return label
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .systemBackground
        [courseImageView, courseTitleLabel, courseInstructorLabel,
         courseDurationLabel, courseAmountLabel, courseDescriptionLabel].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        courseTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        courseImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.size.equalTo(100)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        courseInstructorLabel.snp.makeConstraints { make in
            make.top.equalTo(courseImageView.snp.bottom).offset(4)
            make.centerX.equalTo(courseImageView)
        }
        
        courseDurationLabel.snp.makeConstraints { make in
            make.top.equalTo(courseInstructorLabel.snp.bottom).offset(4)
            make.centerX.equalTo(courseImageView)
        }
        
        courseAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(courseDurationLabel.snp.bottom).offset(4)
            make.centerX.equalTo(courseImageView)
        }
        
        courseDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(courseTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(courseImageView.snp.leading).offset(-16)
        }
    }
    
    private func setupNavigation() {
        navigationItem.title = "Детали"
        navigationItem.largeTitleDisplayMode = .never
    }

}
