//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

protocol FeedLoadingView {
	func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedView {
	func display(_ viewModel: FeedViewModel)
}

protocol FeedErrorLoadingView {
	func display(_ viewModel: FeedLoadingErrorViewModel)
	func hide()
}

final class FeedPresenter {
	private let feedView: FeedView
	private let loadingView: FeedLoadingView
	private let errorView: FeedErrorLoadingView

	init(feedView: FeedView, loadingView: FeedLoadingView, errorView: FeedErrorLoadingView) {
		self.feedView = feedView
		self.loadingView = loadingView
		self.errorView = errorView
	}

	func didStartLoadingFeed() {
		errorView.hide()
		loadingView.display(FeedLoadingViewModel(isLoading: true))
	}

	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}

	func didFinishLoadingFeed(with error: Error) {
		loadingView.display(FeedLoadingViewModel(isLoading: false))
		errorView.display(FeedLoadingErrorViewModel(error: Localized.Feed.loadError))
	}
}
