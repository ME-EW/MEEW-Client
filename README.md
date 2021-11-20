# MEEW-Client

### 🎁 서비스 소개 
|서비스 명|서비스 소개|
|--|--|
|ME:EW|서로를 이해하기 위한 가장 좋은 방법, 너로 살아보기|

<br />

### 📺 개발 담당 부분
|담당 뷰와 기능|담당자|구현 정도와 뷰 설명|
|--|--|--|
|Result View|`태현`|UI 완성, 서버 연결 시도 - 그 동안 경험해봤던 캐릭터를 모아볼 수 있는 View|
|Select View|`현주`|UI완성, 서버 연결 성공 - Collection View FlowLayout을 통해 해당 캐릭터를 선택할 수 있도록 구현|
|ToDo View|`주민`|UI 완성, 서버 부분 연결 성공 - 내 캐릭터가 아닌 다른 캐릭터와 관련된 TodoList 구현|



<br />

### 🗒 코드 컨벤션

1. **Class 이름**
    - 클래스 이름은 UpperCamelCase 사용하기
    
    ```python
    ex. HomeViewController.swift
    ```
    
2. **Protocol 사용 시**
    - 프로토콜을 채택해서 사용하는 경우 extension으로 분리해서 작성하기
    
    ```swift
    extension HomeViewController: UITableViewDelegate { ... }
    extension HomeViewController: UITableViewDatasource { ... }
    ...
    ```

3. **변수 및 상수 이름**
    - 변수 및 상수 이름은 lowerCamelCase를 사용하기
    
    ```swift
    @IBOutlet weak var tableView: UITableView!
    var phoneNumberList: [String] = []
    ```
    
4. **함수 이름** 
    - 함수 이름은 lowerCamelCase를 사용하기
    - 동작과 관련된 함수(ex. IBActions)는 최대한 자세하게 동사의 형태로 기술하기
    
    ```swift
    @IBAction func loginButtonClicked() { ... }
    @IBAction func backButtonTapped() { ... }
    @objc func increaseButtonClicked() { ... }
    ```
    
5. **생명주기(Life Cycle)**
    - viewDidLoad, viewWillAppear 등 생명 주기에는 최대한 코드를 간단하게 작성하기 → 함수 호출 정도로 제한
    
    ```swift
    override func viewDidLoad() {
    	super.viewDidLoad()
    
    	// 간단하게 함수 호출
    	configureUI()    // UI 세팅
    	tableViewSetup() // 테이블뷰 세팅
    	...
    }
    ```
    
6. **주석 작성**
    - 대부분 모든 코드에 주석 달기
    - // MARK: -
        - MARK: - 이용해서 주석 다는 것은 영역 구분
    - /// 주석 내용
        - 슬래시 3개로 주석 다는 것은 상세 내용
    
    ```swift
    // MARK: - Properties
    // MARK: - Life Cycle
    // MARK: - Custom Function
    // MARK: - TableView Datasource
    ```


<br />

### ✅ git 사용 전략
> 커밋 컨벤션
```
✅[CHORE] : 코드 수정, 내부 파일 수정
✨[FEAT] : 새로운 기능 구현
➕[ADD] : Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 파일 생성 시
🍱[ADD] : 에셋 추가
🚑️[HOTFIX] : issue나, QA에서 급한 버그 수정에 사용
🔨[FIX] : 버그, 오류 해결
⚰️ [DEL] : 쓸모없는 코드 삭제
📝[DOCS] : README나 WIKI 등의 문서 개정
💄[MOD] : storyboard 파일,UI 수정한 경우
✏️ [CORRECT] : 주로 문법의 오류나 타입의 변경, 이름 변경 등에 사용합니다.
🚚[MOVE] : 프로젝트 내 파일이나 코드의 이동
⏪️[RENAME] : 파일 이름 변경이 있을 때 사용합니다.
⚡️[IMPROVE] : 향상이 있을 때 사용합니다.
♻️[[REFACTOR] : 전면 수정이 있을 때 사용합니다
🔀[MERGE]: 다른브렌치를 merge 할 때 사용합니다.
```

> 깃 브랜치 전략

- 해커톤의 성격상 빠른 작업이 이루어져야 하므로, 브랜치 생성을 최소화하여 작업의 효율을 높입니다.
- 브랜치는 각 `dev-작업자명`으로 생성합니다.
- ex. dev-hyunju
```
main
dev           (default 브랜치)
dev-hyunju
dev-jumin
dev-taehyeon
```

> Commit, Pull, Push, Issue, PR

0. 새로운 작업이 진행 전, Pull을 반드시 진행합니다.
1. Issue는 기능 단위로 생성합니다.
2. Issue에 관한 Commit과 Push는 본인 브랜치로 진행합니다.
3. PR은 모든 작업이 완료된 후 진행합니다.

<br />

### 🗂 폴더링

```
📦 MEEW-Client
|
+ 🗂 Networks/
|
+------🗂 APIConstants/
│         └── APIConstants
|
+------🗂 APIModels/
│         └── GenericResponse
|
+------🗂 APIServices/
│         └── NetworkResult
|
+ 🗂 Global/
|
+------🗂 Resources/
│         │── 🗂 Colors/
│         │── 🗂 Fonts/
│         └── 🗂 Images/
|
+------🗂 Extensions/
|
+------🗂 Supports/
│         │── AppDelegate
│         └── SceneDelegate
|
+ 🗂 Screens/
|
+------🗂 Base/
│         │── 🗂 Cell/
│         │── 🗂 Controller/
│         │── 🗂 View/
│         └── 🗂 Storyboard/
|
+------🗂 Select/
|
+------🗂 ToDo/
|
+------🗂 Result/
```



