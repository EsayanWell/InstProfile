//
//  ViewController.swift
//  InstProfile
//
//  Created by Владимир Есаян on 18.09.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - constants and vars
    // массив историй
    private var storiesArray: [Story] = []
    private var postsArray: [Post] = []
    // макет для таблицы
    private let instLayout = UICollectionViewFlowLayout()
    
    private var instCollectionView: UICollectionView!

//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInstCollectionView()
        view.backgroundColor = .black
        title = "elonmuskrus"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        // приравнял массивы
        storiesArray = fetchStoryData()
        postsArray = fetchPostData()
    }
    
    private func makeLayout() -> UICollectionViewCompositionalLayout {
           let layout = UICollectionViewCompositionalLayout { [unowned self] sectionIndex, _ in
               switch sectionIndex {
               case 0: return makeStoriesSection()
               case 1: return makePostsSection()
               default: return nil
               }
           }
           return layout
       }

       private func makeStoriesSection() -> NSCollectionLayoutSection {
           let item = NSCollectionLayoutItem(layoutSize: .init(
               widthDimension: .fractionalWidth(1),
               heightDimension: .fractionalHeight(1)
           ))
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(60), heightDimension: .absolute(90)), subitems: [item])
           let section = NSCollectionLayoutSection(group: group)
           section.interGroupSpacing = 30
           section.orthogonalScrollingBehavior = .continuous
           return section
       }

       private func makePostsSection() -> NSCollectionLayoutSection {
           let item = NSCollectionLayoutItem(layoutSize: .init(
               widthDimension: .fractionalWidth(1/3),
               heightDimension: .fractionalHeight(1)
           ))
           item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(230)), subitems: [item])
           let section = NSCollectionLayoutSection(group: group)
           return section
       }

    
    // MARK: настройка UICollectionView
    
    // коллекция будет занимать всю доступную область текущего представления
    private func setupInstCollectionView() {
        // Настройте макет UICollectionView для вертикального скролла
        instCollectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        instCollectionView.collectionViewLayout = makeLayout()
        instCollectionView.backgroundColor = .black
       
        instCollectionView.translatesAutoresizingMaskIntoConstraints = false
        // подписка на протоколы
        instCollectionView.delegate = self
        instCollectionView.dataSource = self
        // Эта строка регистрирует класс VerticalCell для использования в коллекции с определенным идентификатором "VerticalCell"
        instCollectionView.register(StoryCell.self, forCellWithReuseIdentifier: "StoryCell")
        instCollectionView.register(PostCell.self, forCellWithReuseIdentifier: "PostCell")
        view.addSubview(instCollectionView)
        // настройка constraits
        
        NSLayoutConstraint.activate([
            instCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            instCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            instCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            instCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

// MARK: - UICollectionViewDataSourse
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // кол-во секций (одна для историй, другая для постов)
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // используется для определения количества элементов (ячеек) в указанной секции коллекции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return storiesArray.count
        } else {
            return postsArray.count
        }
    }
    
    // настройка ячеек
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as! StoryCell
            let stories = storiesArray[indexPath.row]
            cell.set(storiesArray: stories)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
            let posts = postsArray[indexPath.row]
            cell.set(postsArray: posts)
            return cell
        }
    }
}


extension ProfileViewController {
    
    // данные для массива
    func fetchStoryData() -> [Story] {
        let story1 = Story(storyImage: storyImages.ufo, storyText: "UFO")
        let story2 = Story(storyImage: storyImages.starship, storyText: "Starship")
        let story3 = Story(storyImage: storyImages.mars, storyText: "Mars")
        let story4 = Story(storyImage: storyImages.spaceRover, storyText: "Rover")
        let story5 = Story(storyImage: storyImages.telescope, storyText: "Telescope")
        let story6 = Story(storyImage: storyImages.starlink, storyText: "Starlink")
        
        return [story1, story2, story3, story4, story5, story6]
        
    }
    // данные для массива
    func fetchPostData() -> [Post] {
        let post1  = Post(postImage: postImages.post1)
        let post2  = Post(postImage: postImages.post2)
        let post3  = Post(postImage: postImages.post3)
        let post4  = Post(postImage: postImages.post4)
        let post5  = Post(postImage: postImages.post5)
        let post6  = Post(postImage: postImages.post6)
        let post7  = Post(postImage: postImages.post7)
        let post8  = Post(postImage: postImages.post8)
        let post9  = Post(postImage: postImages.post9)
        let post10 = Post(postImage: postImages.post10)
        let post11 = Post(postImage: postImages.post11)
        let post12 = Post(postImage: postImages.post12)
        
        return [post1, post2, post3, post4, post5, post6, post7, post8, post9, post10, post11, post12]
        
    }
}
