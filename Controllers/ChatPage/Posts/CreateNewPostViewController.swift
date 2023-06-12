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
        imageView.backgroundColor = .tertiarySystemBackground /* 593 */
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
