//
//  SelectCarouselLayout.swift
//  MEEW-Client
//
//  Created by 안현주 on 2022/02/25.
//

import Foundation
import UIKit

class SelectCarouselLayout: UICollectionViewFlowLayout {
    var sideItemScale: CGFloat =  1//크기 작아졌다가 커지는 정도
    var sideItemAlpha: CGFloat = 0.5 //그림자 효과?
    var spacing: CGFloat = 10 //요소들간의 간격
    var isPagingEnabled: Bool = false
    private var isSetup: Bool = false
    
    // MARK: prepare는 사용자가 스크롤 시 매번 호출된다고 한다. setupLayout()은 초기에 한 번만 호출되도록 한 것이다.
    override public func prepare() {
        super.prepare()
        
        // 스크롤시 prepare이 매번 호출되니까, 1번만 호출되도록 로직구현
        if isSetup == false {
            setupLayout()
            isSetup = true
        }
    }
    
    // MARK: 컬렉션 뷰 초기 설정
    private func setupLayout() {
        guard let collectionView = self.collectionView else {return}
        let collectionViewSize = collectionView.bounds.size

        let xInset = (collectionViewSize.width - self.itemSize.width) / 2
        self.sectionInset = UIEdgeInsets(top: 0, left: xInset, bottom: 0, right: xInset)
        
        //요소들 사이의 간격 조정
        let itemWidth = self.itemSize.width
        let scaledItemOffset = (itemWidth - (itemWidth * (self.sideItemScale + (1-self.sideItemScale)/2)))/2
        self.minimumLineSpacing = spacing - scaledItemOffset
    
        
        self.scrollDirection = .horizontal
    }
    
    /// true로 반환함으로써 사용자가 스크롤시 prepare()를통해 레이아웃 업데이트가 가능하게 끔
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    /// 모든 셀과 뷰에 대한 레이아웃 속성을 UICollectionViewLayoutAttributes의 배열로 반환해준다고 한다.
    /// 이 속성들을 사용하기 위해 map 함수를 통해 리턴해주었다.
    /// map에서 전달 인자로 받는 함수에 우리가 각 아이템들을 어떻게 변환시킬 것인지에 대한 내용
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
              let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
        else { return nil }
        
        /// transformLayoutAttributes() 함수를 이용해 기존 attributes 속성들을 원하는 대로 변환하고
        /// 이를 attributes에 다시 매핑하여 UICollectionViewLayoutAttributes로 반환한다
        return attributes.map({ self.transformLayoutAttributes(attributes: $0) })
    }
    
    // MARK: 3D효과와 관련된 코드
    //3D 할 경우 수정 해야할 코드
    func transformLayoutAttributes(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else {return attributes}
        
        // 순서대로 컬렉션뷰 크기의 절반, 컬렉션뷰의 컨텐트의 x좌표:예를 들어 한 셀이 지나면 셀의 크기만큼 더해진다, 현재 컨텐트의 오프셋과 각 셀의 중심 좌표의 차이다 : 이는 컬렉션뷰의 오리진 x좌표와 셀의 중심 사이의 거리라고 볼 수 있다.
        // 즉, center는 컬렉션뷰 좌표계를 기준으로 각 셀의 중심의 x표이다.
        // collectionCenter - 컬렉션 뷰의 중앙값으로 변하지 않는 고정 값입니다
        // contentOffset : 사용자가 스크롤할 때 기준점으로부터 offset(이동한 거리)된 거리입니다. (x축) => 가변 값
        // center - 각 아이템(셀)들의 중앙값입니다. => 가변 값
        let collectionCenter = collectionView.frame.size.width / 2
        let contentOffset = collectionView.contentOffset.x
        let center = attributes.center.x - contentOffset
        
        //이제 위의 값들을 기반으로 하여 거리에 따른 비율을 계산하고 그 비율을 갖고서 alpha와 scale 값을 조정하는 공식을 만들게 됩니다.
        
        // 멀리 있는 경우, ratio가 0이 되며 sideItem으로 판별하여 alpha와 scale이 된다.
        // maxDistance보다 가까운 경우, ratio가 1에 가까워지면서 alpha와 scale 값이 1로 온전해진다.
        // distance의 경우, 컬렉션뷰 중심과 각 셀의 중심 사이의 거리이다. 컬렉션뷰 중심으로 셀이 가까이 올수록 거리가 줄어든다. maxdistance를 넣은 이유는 ratio가 음수가 되는 것을 방지하기 위해서이다.
        let maxDistance = self.itemSize.width + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - center), maxDistance)
        
        let ratio = (maxDistance - distance)/maxDistance
        
        //비율을 기반으로 아이템의 스케일과 투명도를 조정
        // 아래에 있는 1을 바꿔서 중심으로 올수록 흐려지거나, 작게 만들 수 있다.
        //ratio가 1일때 alpha, scaled이 1이고 0일떄는 sideItemAlpha, sideItemScale이 되는것을 볼 수 있다.
        let alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha
        let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
        
        
        
        attributes.alpha = alpha
        
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let dist = attributes.frame.midX - visibleRect.midX
        var transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        
        // 1이 한 바퀴 회전이다. 360도임
        // CATransform은 한 번에 하나씩만 사용 가능하다.
        //        transform = CATransform3DMakeRotation(realscale*8, 0, 1, 0)
        
        // 마지막 인자는 z좌표이고, 각 셀이 어떤 셀의 위에 있을지 아닐지를 결정한다. 아래 코드는 거리가 멀수록 화면에서 뒤로 가게끔 만든다(우리가 화면을 바라본다고 가정할 때). +값이라면 우리 눈 앞으로 다가오는 것이다.
        transform = CATransform3DTranslate(transform, 0, 0, -abs(dist/1000))
        attributes.transform3D = transform
        
        return attributes
    }
    
    // MARK: 페이징 가능하게 해주는 코드
    //3D에서 새로 생긴 기능, 스크롤을 중지할 지점을 찾아서 반환하는 메소드
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        //입력 파라미터가 proposedContentOffset, velocity 2가지가 있다
        //1. proposedContentOffset - 스크롤이 자연스럽게 중지 되는 값, point는 visable content의 좌측 위 모서리를 가리킵니다.(visible content는 collectionView bounds의 좌측 모서리 )
        //2. velocity - 스크롤 속도 입니다. (points / sec)
        guard let collectionView = self.collectionView else {
            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            return latestOffset
        }
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
        
        //CGFloat값 중 가장 큰 값을 의미
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        
        //스크롤뷰가 멈출 중앙지점을 얻을 수 있음
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
        
        //itemHorizontalCenter - 각 아이템(셀)들의 x축 중앙 값
        //offsetAdjustment : 스크롤뷰가 멈출것으로 예상되는 포인트에서 가장 가까운 아이템(셀)의 중앙 값을 얻어온 후, 그 값이 스크롤뷰가 멈출 것으로 예상되는 포인트와 얼마나 차이나이는지 계산해서 멈출 지점을 보정해주는데 사용하기 위함
        //반복문을 통해 가장 작은 offsetAdjustment를 갖게 되고 이 값을 스크롤이 멈출 것으로 예상 되는 지점인 proposedContentOffser.x
        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }
        
        //proposedContentOffset을 조절하여 멈추기 원하는 점을 조절가능하다.
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}

