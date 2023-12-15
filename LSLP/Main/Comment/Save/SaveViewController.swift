//
//  SaveViewController.swift
//  LSLP
//
//  Created by 이승현 on 11/29/23.


import UIKit
import Alamofire
import PhotosUI

class SaveViewController: BaseViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let saveView = SaveView()
    var selectedImages = [UIImage]()
    var onPostSuccess: (() -> Void)?

    
    override func loadView() {
        self.view = saveView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeNavigationUI()
        
        saveView.collectionView.delegate = self
        saveView.collectionView.dataSource = self
        saveView.cameraButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        saveView.saveButton.addTarget(self, action: #selector(uploadPost), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleDeleteImage(_:)), name: NSNotification.Name("DeleteImage"), object: nil)
    }
    
    func makeNavigationUI() {
        let layout = UICollectionViewFlowLayout()
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        let logo = UIImage(named: "투명로고")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        navigationItem.titleView = imageView
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func openImagePicker() {
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = 5
            configuration.filter = .images
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            present(picker, animated: true, completion: nil)
        }

    @objc func handleDeleteImage(_ notification: Notification) {
        if let cell = notification.userInfo?["cell"] as? SaveCollectionViewCell,
           let indexPath = saveView.collectionView.indexPath(for: cell) {
            selectedImages.remove(at: indexPath.row)
            saveView.collectionView.deleteItems(at: [indexPath])
            updatePhotoCountLabel()
        }
    }

//    @objc func uploadPost() {
//        guard let title = saveView.titleTextField.text,
//              let content = saveView.contentTextField.text,
//              !selectedImages.isEmpty else {
//            print("입력값 오류 또는 액세스 토큰이 없음")
//            return
//        }
//
//        PostUpload.shared.uploadPost(with: title, content: content, images: selectedImages) { result in
//            switch result {
//            case .success(_):
//                print("응답 성공")
//                self.showUploadSuccessAlert()
//                self.onPostSuccess?()
//            case .failure(let error):
//                print("응답 실패: \(error.localizedDescription)")
//                if error.asAFError?.responseCode == 419 {
//                    self.refreshToken()
//                }
//            }
//        }
//    }
    
    @objc func uploadPost() {
        guard let title = saveView.titleTextField.text,
              let content = saveView.contentTextField.text,
              !selectedImages.isEmpty,
              let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("입력값 오류 또는 액세스 토큰이 없음")
            return
        }

        let headers: HTTPHeaders = [
            "Authorization": accessToken,
            "Content-type": "multipart/form-data",
            "SesacKey": SesacLSLP.key
        ]

        AF.upload(multipartFormData: { [weak self] multipartFormData in
            self?.selectedImages.forEach { image in
                if let imageData = image.jpegData(compressionQuality: 0.2) {
                    multipartFormData.append(imageData, withName: "file", fileName: "file.jpg", mimeType: "image/jpeg")
                }
            }
            multipartFormData.append(Data(title.utf8), withName: "title")
            multipartFormData.append(Data(content.utf8), withName: "content")
            multipartFormData.append(Data("Matchelin".utf8), withName: "product_id")
            
        }, to: SesacLSLP.baseURL + "/post", method: .post, headers: headers)
        .responseJSON { response in
            
            guard let statusCode = response.response?.statusCode else {
                print("응답 실패: \(response.error?.localizedDescription ?? "Unknown error")")
                return
            }

            switch statusCode {
            case 200:
                print("응답 성공: \(response.value ?? "No data")")
                self.showUploadSuccessAlert()
                self.onPostSuccess?()
            case 419:
                print("액세스 토큰 만료 - 토큰 갱신 필요")
                self.refreshToken()
            default:
                print("응답 실패 - 상태 코드: \(statusCode)")
            }
        }
    }


    func refreshToken() {
            NetworkManager.shared.refreshToken { success, errorMessage in
                if success {
                    print("토큰 갱신 성공")
                    self.uploadPost()
                } else {
                    print("토큰 갱신 실패: \(errorMessage ?? "Unknown error")")
                    let loginVC = LoginViewController()
                    self.present(loginVC, animated: true, completion: nil)
                }
            }
        }
    
    private func showUploadSuccessAlert() {
        let alert = UIAlertController(title: "", message: "게시글이 등록되었습니다!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}



extension SaveViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SaveCollectionViewCell", for: indexPath) as? SaveCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.imageView.image = selectedImages[indexPath.row]
            return cell
        }
}


extension SaveViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        selectedImages.removeAll()
        let group = DispatchGroup()

        for result in results {
            group.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                defer { group.leave() }
                if let image = image as? UIImage {
                    self?.selectedImages.append(image)
                }
            }
        }

        group.notify(queue: .main) { [weak self] in
            self?.saveView.collectionView.reloadData()
            self?.updatePhotoCountLabel()
        }
    }

    private func updatePhotoCountLabel() {
        saveView.photoCountLabel.text = "\(selectedImages.count)/5"
    }
}







