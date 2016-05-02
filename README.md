###EC503 Learning from data final project
####Clustering and Visualization of Stock Data
Ganyu Lian, Qiuxuan Lin and Aleena Polansky

> Abstract
> In finance, portfolio optimization is a forward-looking issue as the market dynamics constantly evolve under the influence of human activities.Hereby, we investigate the hidden patterns in the stock market, using Standard and Poor's 500.Clustering algorithms are introduced as we strive to explore the intrinsic relationship between stocks.The optimized asset choice shows comparably good performance, which is based on the two theoretical frameworks, random matrix theory(RMT) and principle component analysis in machine learning.

This repository contains,

- Data: S&P 500 achieved from Yahoo Finance, raw data is log returns of each day over 2010.01 to 2016.03 of 437 stocks
- Clustering: clustering method on both raw data and RMT preprocessed data
- Visualization and Performance Metrics: we introduce ISOMAP and Maximum Spanning Tree as visualization and evaluation, also used performance metrics for clusters
- Portfolio: constructing and optimizing portfolio using Mean Variance Analysis
- Index results: demo of indices we got from different approaches