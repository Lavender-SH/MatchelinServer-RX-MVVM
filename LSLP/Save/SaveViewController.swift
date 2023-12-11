//
//  SaveViewController.swift
//  LSLP
//
//  Created by 이승현 on 11/29/23.
//

import UIKit
import Alamofire

class SaveViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let saveView = SaveView()
    
    override func loadView() {
        self.view = saveView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeNavigationUI()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        saveView.imageView.addGestureRecognizer(tapGesture1)
        saveView.imageView.isUserInteractionEnabled = true
        
        saveView.saveButton.addTarget(self, action: #selector(uploadPost), for: .touchUpInside)
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
    
    // MARK: - 이미지 피커 델리게이트 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            saveView.imageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - 이미지 피커 함수
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedImageView = sender.view as? UIImageView else { return }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.view.tag = tappedImageView.tag
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func uploadPost() {
        guard let title = saveView.titleTextField.text,
              let content = saveView.contentTextField.text,
              let image = saveView.imageView.image,
              let imageData = image.jpegData(compressionQuality: 0.5),
              let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
            print("입력값 오류 또는 액세스 토큰이 없음")
            return
        }

        let headers: HTTPHeaders = [
            "Authorization": accessToken,
            "Content-type": "multipart/form-data",
            "SesacKey": SesacLSLP.key
        ]

        AF.upload(multipartFormData: { multipartFormData in
            
            let mimeType: String
            let fileExtension: String
            let fileName: String = "file"

            if let imageData = image.jpegData(compressionQuality: 0.5) {
                mimeType = "image/jpeg"
                fileExtension = "jpg"
            } else if let imageData = image.pngData() {
                mimeType = "image/png"
                fileExtension = "png"
            } else {
                print("지원하지 않는 파일 형식")
                return
            }
            multipartFormData.append(imageData, withName: "file", fileName: "\(fileName).\(fileExtension)", mimeType: mimeType)
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

    
    
    
    
}

