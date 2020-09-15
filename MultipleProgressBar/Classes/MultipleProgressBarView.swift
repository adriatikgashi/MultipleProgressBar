import UIKit

public final class MultiProgressView: UIView {
    
    // MARK: - Private properties
    private var kUsageModels: [UsagesModel] = []
    private let kMinimumInteritemSpacingForSectionAt: CGFloat = 1
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.layer.cornerRadius = 6
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        start()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.collectionView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveLinear, animations: {
            self.layoutIfNeeded()
        })
    }
    
    // MARK: - Public methods
    public func updateViews(usageModels: [UsagesModel]) {
        self.kUsageModels = usageModels
        self.collectionView.reloadData()
    }
    
    private func start() {
        setupViews()
        registerCells()
    }
    
    private func registerCells() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))
    }
    
    private func setupViews() {
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

 // MARK: - UICollectionViewDelegate && UICollectionViewDataSource && UICollectionViewDelegateFlowLayout
extension MultiProgressView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kUsageModels.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UICollectionViewCell.self), for: indexPath)
        cell.backgroundColor = kUsageModels[indexPath.item].color
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return kMinimumInteritemSpacingForSectionAt
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sumOfAll = kUsageModels.map({ $0.value }).reduce(0,+)
        let widthOfCollectionView = collectionView.frame.width - CGFloat(kMinimumInteritemSpacingForSectionAt * CGFloat(kUsageModels.count))
        let width = widthOfCollectionView / CGFloat(sumOfAll) * CGFloat(kUsageModels[indexPath.item].value)
        let height = collectionView.frame.height
        let size = CGSize(width: width, height: height)
        return size
    }
}

