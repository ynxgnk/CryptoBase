//
//  CreateNewPostViewController.swift
//  swiftCoin
//
//  Created by Nazar Kopeika on 08.06.2023.
//



import UIKit

class CreateNewPostViewController: UIViewController {

    //Title Field
    private let titleField: UITextField = { /* 593 */
        let field = UITextField() /* 593 */
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50)) /* 593 */
        field.leftViewMode = .always /* 593 */
        field.placeholder = "Enter Title..." /* 593 */
        field.layer.cornerRadius = 8 /* 606 */
        field.autocapitalizationType = .words /* 593 */
        field.autocorrectionType = .no /* 593 */
        field.backgroundColor = .secondarySystemBackground /* 593 */
        field.layer.masksToBounds = true /* 593 */
        return field /* 593 */
    }()
    
    //Image header
    private let headerImageView: UIImageView = { /* 593 */
        let imageView = UIImageView() /* 593 */
        imageView.contentMode = .scaleAspectFill /* 593 */
        imageView.isUserInteractionEnabled = true /* 593 */
        imageView.clipsToBounds = true /* 593 */
        imageView.image = UIImage(systemName: "photo") /* 593 */
        imageView.backgroundColor = .systemBackground /* 593 */
        return imageView /* 593 */
    }()
    
    //TextView for post
    private let textView: UITextView = { /* 593 */
        let textView = UITextView() /* 593 */
        textView.backgroundColor = .secondarySystemBackground /* 593 */
        textView.autocorrectionType = .no /* 593 */
        textView.layer.cornerRadius = 8 /* 606 */
        textView.isEditable = true /* 593 */
        textView.font = .systemFont(ofSize: 28) /* 593 */
        return textView /* 593 */
    }()
    
    private var selectedHeaderImage: UIImage? /* 593 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground /* 593 */
        view.addSubview(headerImageView) /* 593 */
        view.addSubview(textView) /* 593 */
        view.addSubview(titleField) /* 593 */
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(didTapHeader)) /* 593 */
        headerImageView.addGestureRecognizer(tap) /* 593 */
        configureButtons() /* 593 */
    }
    
    override func viewDidLayoutSubviews() { /* 593 */
        super.viewDidLayoutSubviews() /* 593 */
        
        titleField.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.width-20, height: 50) /* 593 */
        headerImageView.frame = CGRect(x: 0, y: titleField.bottom+5, width: view.width, height: 300) /* 593 */
        textView.frame = CGRect(x: 10, y: headerImageView.bottom+10, width: view.width-20, height: view.height-210-view.safeAreaInsets.top) /* 593 */
    }
    
    @objc private func didTapHeader() { /* 593 */
        let picker = UIImagePickerController() /* 593 */
        picker.sourceType = .photoLibrary /* 593 */
        picker.delegate = self /* 593 */
        present(picker, animated: true) /* 593 */
    }
    
    private func configureButtons() { /* 593 */
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .done,
            target: self,
            action: #selector(didTapCancel) /* 593 */
        )

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Post",
            style: .done,
            target: self,
            action: #selector(didTapPost) /* 593 */
        )
    }
    
    @objc private func didTapCancel() { /* 593 */
        dismiss(animated: true, completion: nil) /* 593 */
    }
    
    @objc private func didTapPost() { /* 593 */
        //Check data and post
        guard let title = titleField.text,
              let body = textView.text,
              let headerImage = selectedHeaderImage,
              let email = UserDefaults.standard.string(forKey: "email"), /* 593 */
        !title.trimmingCharacters(in: .whitespaces).isEmpty,
        !body.trimmingCharacters(in: .whitespaces).isEmpty else { /* 593 */
            
            let alert = UIAlertController(title: "Enter Post Details",
                                          message: "Please enter a title, body, and select a image to continue.",
                                          preferredStyle: .alert) /* 593 */
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)) /* 593 */
            present(alert, animated: true) /* 593 */
            return /* 593 */
        }
        
        print("Starting post...") /* 593 */
        
        let newPostId = UUID().uuidString /* 593 */
        
        //Upload header Image
        StorageManager.shared.uploadBlogHeaderImage( /* 593 */
            email: email,
            image: headerImage,
            postId: newPostId
        ) { success in
            guard success else { /* 593 */
                return /* 593 */
                //tyt
            }
            StorageManager.shared.downloadUrlForPostHeader(email: email, postId: newPostId) { url in /* 593 */
                guard let headerUrl = url else { /* 593 */
//                    print("Failed to upload url for header") /* 593 */
                    DispatchQueue.main.async { /* 593 */
                        HapticsManager.shared.vibrate(for: .error) /* 593 */
                    }
                    return /* 593 */
                }
                
                //Insert of post into DB
                
                let post = BlogPost(
                    identifier: newPostId, /* 593 change UUID().uuidString to postId */
                    title: title,
                    timestamp: Date().timeIntervalSince1970,
                    headerImageUrl: headerUrl,
                    text: body
                ) /* 593 */
                
                DatabaseManager.shared.insert(blogPost: post, email: email) { [weak self] posted in /* 593 */
                    guard posted else { /* 593 */
//                        print("Failed to post new Blog Article") /* 593 */
                        DispatchQueue.main.async { /* 593 */
                            HapticsManager.shared.vibrate(for: .error) /* 593 */
                        }
                        return /* 593 */
                    }
                    
                    DispatchQueue.main.async { /* 593 */
                        HapticsManager.shared.vibrate(for: .success) /* 593 */
                        self?.didTapCancel() /* 593 */
                    }
                }
            }
        }
    }
}

extension CreateNewPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate { /* 593 */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) { /* 593 */
        picker.dismiss(animated: true, completion: nil) /* 593 */
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) { /* 593 */
        picker.dismiss(animated: true, completion: nil) /* 593 */
        guard let image = info[.originalImage] as? UIImage else { /* 593 */
            return /* 593 */
        }
        selectedHeaderImage = image /* 593 */
        headerImageView.image = image /* 593 */
    }
}



/*

//
//  CreateNewPostViewController.swift
//  Thoughts
//
//  Created by Afraz Siddiqui on 7/11/21.
//

import UIKit

class CreateNewPostViewController: UITabBarController {

    // Title field
    private let titleField: UITextField = {
        let field = UITextField()
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "Enter Title..."
        field.autocapitalizationType = .words
        field.autocorrectionType = .yes
        field.backgroundColor = .secondarySystemBackground
        field.layer.masksToBounds = true
        return field
    }()

    // Image Header
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "photo")
        imageView.backgroundColor = .tertiarySystemBackground
        return imageView
    }()

    // TextView for post
    private let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .secondarySystemBackground
        textView.isEditable = true
        textView.font = .systemFont(ofSize: 28)
        return textView
    }()

    private var selectedHeaderImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(headerImageView)
        view.addSubview(textView)
        view.addSubview(titleField)
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(didTapHeader))
        headerImageView.addGestureRecognizer(tap)
        configureButtons()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        titleField.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.width-20, height: 50)
        headerImageView.frame = CGRect(x: 0, y: titleField.bottom+5, width: view.width, height: 160)
        textView.frame = CGRect(x: 10, y: headerImageView.bottom+10, width: view.width-20, height: view.height-210-view.safeAreaInsets.top)
    }

    @objc private func didTapHeader() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }

    private func configureButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .done,
            target: self,
            action: #selector(didTapCancel)
        )

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Post",
            style: .done,
            target: self,
            action: #selector(didTapPost)
        )
    }

    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapPost() {
        // Check data and post
        guard let title = titleField.text,
              let body = textView.text,
              let headerImage = selectedHeaderImage,
              let email = UserDefaults.standard.string(forKey: "email"),
              !title.trimmingCharacters(in: .whitespaces).isEmpty,
              !body.trimmingCharacters(in: .whitespaces).isEmpty else {

            let alert = UIAlertController(title: "Enter Post Details",
                                          message: "Please enter a title, body, and select a image to continue.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }

        print("Starting post...")

        let newPostId = UUID().uuidString

        // Upload header Image
        StorageManager.shared.uploadBlogHeaderImage(
            email: email,
            image: headerImage,
            postId: newPostId
        ) { success in
            guard success else {
                print("Error")
                return
            }
            StorageManager.shared.downloadUrlForPostHeader(email: email, postId: newPostId) { url in
                guard let headerUrl = url else {
                    DispatchQueue.main.async {
                        HapticsManager.shared.vibrate(for: .error)
                    }
                    return
                }
                print("post added")

                // Insert of post into DB

                let post = BlogPost(
                    identifier: newPostId,
                    title: title,
                    timestamp: Date().timeIntervalSince1970,
                    headerImageUrl: headerUrl,
                    text: body
                )

                DatabaseManager.shared.insert(blogPost: post, email: email) { [weak self] posted in
                    guard posted else {
                        DispatchQueue.main.async {
                            HapticsManager.shared.vibrate(for: .error)
                        }
                        return
                    }

                    DispatchQueue.main.async {
                        HapticsManager.shared.vibrate(for: .success)
                        self?.didTapCancel()
                    }
                }
            }
        }
    }
}

extension CreateNewPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        selectedHeaderImage = image
        headerImageView.image = image
    }
}
*/
