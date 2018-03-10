
**Observed Trends**
- Overall compound sentiment for the last 100 Tweets for all five media channels is negative
- Fox News and BBC World compound sentiments are the most negative
- NY Times is the only Media Source with an overall positive sentiment


```python
# Dependencies
import tweepy
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import csv
import pandas as pd

# Import and Initialize Sentiment Analyzer
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
analyzer = SentimentIntensityAnalyzer()

# Twitter API Keys
from localenv import (consumer_key, 
                    consumer_secret, 
                    access_token, 
                    access_token_secret)

# Setup Tweepy API Authentication
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth, parser=tweepy.parsers.JSONParser())
```


```python
# Target User Account BBC, CBS, CNN, Fox, and New York times
target_user = ("@BBCWorld", "@CBSNews", "@CNN", "@FoxNews", "@nytimes")

# Variables for holding sentiments
sentiments = []
oldest_tweet = None

# Counter
counter = 1

for target in target_user:

    # Get 100 tweets from home feed
    public_tweets = api.user_timeline(target,
                                      count=100,
                                      result_type="recent",
                                      max_id=oldest_tweet)

    # Loop through all tweets
    for tweet in public_tweets:

        # Run Vader Analysis on each tweet
        results = analyzer.polarity_scores(tweet["text"])
        compound = results["compound"]
        pos = results["pos"]
        neu = results["neu"]
        neg = results["neg"]
        tweets_ago = counter
        

            # Add each value to the appropriate list
        sentiments.append({"Date": tweet["created_at"], 
                           "Media": target,
                           "Compound": compound,
                           "Positive": pos,
                           "Negative": neu,
                           "Neutral": neg,
                           "Tweets Ago": counter
                           })
        # Add to counter 
        counter = counter + 1
    counter=1
oldest_tweet = int(tweet['id_str']) - 1
```


```python
#Create DataFrame
sentiment = pd.DataFrame.from_dict(sentiments)
sentiment.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Compound</th>
      <th>Date</th>
      <th>Media</th>
      <th>Negative</th>
      <th>Neutral</th>
      <th>Positive</th>
      <th>Tweets Ago</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0.0000</td>
      <td>Sat Mar 10 09:02:46 +0000 2018</td>
      <td>@BBCWorld</td>
      <td>1.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0.1139</td>
      <td>Sat Mar 10 08:46:00 +0000 2018</td>
      <td>@BBCWorld</td>
      <td>0.659</td>
      <td>0.157</td>
      <td>0.184</td>
      <td>2</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.5719</td>
      <td>Sat Mar 10 06:38:00 +0000 2018</td>
      <td>@BBCWorld</td>
      <td>0.598</td>
      <td>0.000</td>
      <td>0.402</td>
      <td>3</td>
    </tr>
    <tr>
      <th>3</th>
      <td>-0.1280</td>
      <td>Sat Mar 10 06:07:53 +0000 2018</td>
      <td>@BBCWorld</td>
      <td>0.842</td>
      <td>0.158</td>
      <td>0.000</td>
      <td>4</td>
    </tr>
    <tr>
      <th>4</th>
      <td>-0.4019</td>
      <td>Sat Mar 10 05:55:35 +0000 2018</td>
      <td>@BBCWorld</td>
      <td>0.748</td>
      <td>0.252</td>
      <td>0.000</td>
      <td>5</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Save df to CSV
sentiment.to_csv("Sentiment_Analysis")
```


```python
#Obtain x and y coordinates for each media
BBC = sentiment[sentiment["Media"] == "@BBCWorld"]
CBSNews = sentiment[sentiment["Media"] == "@CBSNews"]
CNN = sentiment[sentiment["Media"] == "@CNN"]
FoxNews = sentiment[sentiment["Media"] == "@FoxNews"]
nytimes = sentiment[sentiment["Media"] == "@nytimes"]

BBC_Tweets = pd.DataFrame(BBC.groupby('Tweets Ago')['Compound'].unique())
BBC_Tweets.reset_index(inplace=True)
BBC_Tweets.columns=['Tweets Ago', 'Compound']

CBS_Tweets = pd.DataFrame(CBSNews.groupby('Tweets Ago')['Compound'].unique())
CBS_Tweets.reset_index(inplace=True)
CBS_Tweets.columns=['Tweets Ago', 'Compound']

CNN_Tweets = pd.DataFrame(CNN.groupby('Tweets Ago')['Compound'].unique())
CNN_Tweets.reset_index(inplace=True)
CNN_Tweets.columns=['Tweets Ago', 'Compound']

Fox_Tweets = pd.DataFrame(FoxNews.groupby('Tweets Ago')['Compound'].unique())
Fox_Tweets.reset_index(inplace=True)
Fox_Tweets.columns=['Tweets Ago', 'Compound']

NYT_Tweets = pd.DataFrame(nytimes.groupby('Tweets Ago')['Compound'].unique())
NYT_Tweets.reset_index(inplace=True)
NYT_Tweets.columns=['Tweets Ago', 'Compound']
```


```python
#Plot Compound vs. Tweets
plt.figure(figsize=(12,8))

plt.scatter(BBC_Tweets['Tweets Ago'],
            BBC_Tweets['Compound'],
            s=100,
            c="blue",
            alpha=0.8, 
            linewidths=2,
            edgecolors='grey', 
            label="BBC")

plt.scatter(CBS_Tweets['Tweets Ago'],
            CBS_Tweets['Compound'],
            s=100,
            c="orange",
            alpha=0.8, 
            linewidths=2,
            edgecolors='grey', 
            label="CBS")

plt.scatter(CNN_Tweets['Tweets Ago'],
            CNN_Tweets['Compound'],
            s=100,
            c="green",
            alpha=0.8, 
            linewidths=2,
            edgecolors='grey', 
            label="CNN")

plt.scatter(Fox_Tweets['Tweets Ago'],
            Fox_Tweets['Compound'],
            s=100,
            c="red",
            alpha=0.8, 
            linewidths=2,
            edgecolors='grey', 
            label="Fox News")

plt.scatter(NYT_Tweets['Tweets Ago'],
            NYT_Tweets['Compound'],
            s=100,
            c="purple",
            alpha=0.8, 
            linewidths=2,
            edgecolors='grey', 
            label="NY Times")

plt.xlabel("Tweets Ago", fontsize='large')
plt.ylabel("Polarity", fontsize='large')
plt.title("Sentiment Analysis of Media Tweets (March 2018)", size=20)
plt.xlim(0,101)

plt.legend(bbox_to_anchor=(1, 1), title="Media Source", fancybox=True, shadow=True, borderpad=1)

plt.grid(True)
plt.show()
plt.savefig("Analysis_3-10-2018.png")
```


![png](output_6_0.png)



    <matplotlib.figure.Figure at 0x1a22cd6518>



```python
ttl_sentiment = pd.DataFrame(sentiment.groupby('Media')['Compound'].sum())
ttl_sentiment.reset_index(inplace=True)
ttl_sentiment.columns=['Media', 'Compound']
ttl_sentiment
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Media</th>
      <th>Compound</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>@BBCWorld</td>
      <td>-10.5354</td>
    </tr>
    <tr>
      <th>1</th>
      <td>@CBSNews</td>
      <td>-7.1409</td>
    </tr>
    <tr>
      <th>2</th>
      <td>@CNN</td>
      <td>-3.8184</td>
    </tr>
    <tr>
      <th>3</th>
      <td>@FoxNews</td>
      <td>-12.2082</td>
    </tr>
    <tr>
      <th>4</th>
      <td>@nytimes</td>
      <td>3.7227</td>
    </tr>
  </tbody>
</table>
</div>




```python
overall_sent = ttl_sentiment['Compound'].sum()
overall_sent
```




    -29.9802




```python
# Overall sentiments of the last 100 tweets from each media source:
sns.barplot(ttl_sentiment['Media'], ttl_sentiment['Compound'])
plt.title("Overal Sentiment last 100 Tweets", size=18)
plt.show()
plt.savefig("Sentiment_Overall_3-10-2018.png")
```


![png](output_9_0.png)



    <matplotlib.figure.Figure at 0x1a20949ba8>

