
**Player Count**

* Total Number of Players

**Purchasing Analysis (Total)**

* Number of Unique Items
* Average Purchase Price
* Total Number of Purchases
* Total Revenue

**Gender Demographics**

* Percentage and Count of Male Players
* Percentage and Count of Female Players
* Percentage and Count of Other / Non-Disclosed

**Purchasing Analysis (Gender)** 

* The below each broken by gender
  * Purchase Count
  * Average Purchase Price
  * Total Purchase Value
  * Normalized Totals

**Age Demographics**

* The below each broken into bins of 4 years (i.e. &lt;10, 10-14, 15-19, etc.) 
  * Purchase Count
  * Average Purchase Price
  * Total Purchase Value
  * Normalized Totals

**Top Spenders**

* Identify the the top 5 spenders in the game by total purchase value, then list (in a table):
  * SN
  * Purchase Count
  * Average Purchase Price
  * Total Purchase Value

**Most Popular Items**

* Identify the 5 most popular items by purchase count, then list (in a table):
  * Item ID
  * Item Name
  * Purchase Count
  * Item Price
  * Total Purchase Value

**Most Profitable Items**

* Identify the 5 most profitable items by total purchase value, then list (in a table):
  * Item ID
  * Item Name
  * Purchase Count
  * Item Price
  * Total Purchase Value

As final considerations:

* Your script must work for both data-sets given.
* You must use the Pandas Library and the Jupyter Notebook.
* You must submit a link to your Jupyter Notebook with the viewable Data Frames. 
* You must include an exported markdown version of your Notebook called  `README.md` in your GitHub repository.  
* You must include a written description of three observable trends based on the data. 
* See [Example Solution](HeroesOfPymoli/HeroesOfPymoli_Example.pdf) for a reference on expected format. 
 

## Hints and Considerations

* These are challenging activities for a number of reasons. For one, these activities will require you to analyze thousands of records. Hacking through the data to look for obvious trends in Excel is just not a feasible option. The size of the data may seem daunting, but Python Pandas will allow you to efficiently parse through it. 

* Second, these activities will also challenge you by requiring you to learn on your feet. Don't fool yourself into thinking: "I need to study Pandas more closely before diving in." Get the basic gist of the library and then _immediately_ get to work. When facing a daunting task, it's easy to think: "I'm just not ready to tackle it yet." But that's the surest way to never succeed. Learning to program requires one to constantly tinker, experiment, and learn on the fly. You are doing exactly the _right_ thing, if you find yourself constantly practicing Google-Fu and diving into documentation. There is just no way (or reason) to try and memorize it all. Online references are available for you to use when you need them. So use them!

* Take each of these tasks one at a time. Begin your work, answering the basic questions: "How do I import the data?" "How do I convert the data into a DataFrame?" "How do I build the first table?" Don't get intimidated by the number of asks. Many of them are repetitive in nature with just a few tweaks. Be persistent and creative!

* Expect these exercises to take time! Don't get discouraged if you find yourself spending  hours initially with little progress. Force yourself to deal with the discomfort of not knowing and forge ahead. This exercise is likely to take between 15-30 hours of your time. Consider these hours an investment in your future!

* As always, feel encouraged to work in groups and get help from your TAs and Instructor. Just remember, true success comes from mastery and _not_ a completed homework assignment. So challenge yourself to truly succeed!



```python
import pandas as pd
```


```python
#Import file
file = pd.read_json('purchase_data.json')
file.head()
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
      <th>Age</th>
      <th>Gender</th>
      <th>Item ID</th>
      <th>Item Name</th>
      <th>Price</th>
      <th>SN</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>38</td>
      <td>Male</td>
      <td>165</td>
      <td>Bone Crushing Silver Skewer</td>
      <td>3.37</td>
      <td>Aelalis34</td>
    </tr>
    <tr>
      <th>1</th>
      <td>21</td>
      <td>Male</td>
      <td>119</td>
      <td>Stormbringer, Dark Blade of Ending Misery</td>
      <td>2.32</td>
      <td>Eolo46</td>
    </tr>
    <tr>
      <th>2</th>
      <td>34</td>
      <td>Male</td>
      <td>174</td>
      <td>Primitive Blade</td>
      <td>2.46</td>
      <td>Assastnya25</td>
    </tr>
    <tr>
      <th>3</th>
      <td>21</td>
      <td>Male</td>
      <td>92</td>
      <td>Final Critic</td>
      <td>1.36</td>
      <td>Pheusrical25</td>
    </tr>
    <tr>
      <th>4</th>
      <td>23</td>
      <td>Male</td>
      <td>63</td>
      <td>Stormfury Mace</td>
      <td>1.27</td>
      <td>Aela59</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Code to take a peek at second file
Alt_file = pd.read_json('purchase_data2.json')
```


```python
#Count the number of unique players
Number_Players = file["SN"].unique().size
#Purchasing Analysis: number of unique items
Number_Items = file["Item Name"].unique().size
#Calculate avg purchase price
Avg_Price = file["Price"].mean()
#Count the number of unique purchases
Number_Purchases = file["Item ID"].size
#Add revenue
Revenue = file["Price"].sum()
print(f" Number_of_players: {Number_Players}\n Number_of_items: {Number_Items}\n Average_Price: {Avg_Price}\n Number_of_Purchases: {Number_Purchases}\n Total_Revenue: {Revenue}")
```

     Number_of_players: 573
     Number_of_items: 179
     Average_Price: 2.9311923076923074
     Number_of_Purchases: 780
     Total_Revenue: 2286.33



```python
#Create table to remove user duplicates and find user gender
Gender_Table = pd.DataFrame(file.groupby('SN')['Gender'].unique())
Gender_Table.reset_index(inplace=True)
Gender_Table.columns=["SN","Gender"]
#Count of customers by gender
Gender_count = pd.DataFrame(Gender_Table['Gender'].value_counts())
Gender_count.reset_index(inplace=True)
Gender_count.columns=["Gender","Count"]
Gender_count["Percent of Total"]=(Gender_count["Count"]/Number_Players)*100
Gender_count
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
      <th>Gender</th>
      <th>Count</th>
      <th>Percent of Total</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>[Male]</td>
      <td>465</td>
      <td>81.151832</td>
    </tr>
    <tr>
      <th>1</th>
      <td>[Female]</td>
      <td>100</td>
      <td>17.452007</td>
    </tr>
    <tr>
      <th>2</th>
      <td>[Other / Non-Disclosed]</td>
      <td>8</td>
      <td>1.396161</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Purchasing Analysis (Gender)
Count_by_Gender = pd.DataFrame(file.groupby('Gender')['SN'].count())
Count_by_Gender.reset_index(inplace=True)
Count_by_Gender.columns=["Gender","Purchase Count"]
#Average Purchase Price
Avg_by_Gender = pd.DataFrame(file.groupby('Gender')['Price'].mean())
Avg_by_Gender.reset_index(inplace=True)
Avg_by_Gender.columns=["Gender","Average Price"]
#Total Purchase Value
Ttl_by_Gender = pd.DataFrame(file.groupby("Gender")["Price"].sum())
Ttl_by_Gender.reset_index(inplace=True)
Ttl_by_Gender.columns=["Gender","Total Purchase"]
#Normalized values
Normalized_gender = (pd.DataFrame(file.groupby("Gender")["Price"].sum()))/Gender_count['Count'].sum()
Normalized_gender.reset_index(inplace=True)
Normalized_gender.columns=["Gender","Normalized Values"]
# Create a new table consolidating above calculations
merge_table1 = pd.merge(Count_by_Gender, Avg_by_Gender, on="Gender")
merge_table2 = pd.merge(merge_table1, Ttl_by_Gender, on="Gender")
merge_table = pd.merge(merge_table2, Normalized_gender, on="Gender")
merge_table
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
      <th>Gender</th>
      <th>Purchase Count</th>
      <th>Average Price</th>
      <th>Total Purchase</th>
      <th>Normalized Values</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Female</td>
      <td>136</td>
      <td>2.815515</td>
      <td>382.91</td>
      <td>0.668255</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Male</td>
      <td>633</td>
      <td>2.950521</td>
      <td>1867.68</td>
      <td>3.259476</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Other / Non-Disclosed</td>
      <td>11</td>
      <td>3.249091</td>
      <td>35.74</td>
      <td>0.062373</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Normalized values
Normalized_gender = (pd.DataFrame(file.groupby("Gender")["Price"].sum()))/Gender_count['Count'].sum()
Normalized_gender.reset_index(inplace=True)
Normalized_gender.columns=["Gender","Normalized Values"]
Normalized_gender
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
      <th>Gender</th>
      <th>Normalized Values</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Female</td>
      <td>0.668255</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Male</td>
      <td>3.259476</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Other / Non-Disclosed</td>
      <td>0.062373</td>
    </tr>
  </tbody>
</table>
</div>




```python
Age_Table = pd.DataFrame(file.groupby('SN')['Age'].unique())
Age_Table.reset_index(inplace=True)
Age_Table.columns=["SN","Age"]
Age_Table.head()
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
      <th>SN</th>
      <th>Age</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Adairialis76</td>
      <td>[20]</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Aduephos78</td>
      <td>[37]</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Aeduera68</td>
      <td>[26]</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Aela49</td>
      <td>[25]</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Aela59</td>
      <td>[23]</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Analysis by age groups: Bins are in 4 year increments (Example: <10, 10-14, 15-19, etc.)
Bins = [0,9,14,19,24,29,34,39,44,49]
Group_names = ['<10','10-14','15-19','20-24','25-29','30-34','35-39','40-44','45-49']
group_file= pd.cut(file["Age"], Bins, labels=Group_names)
#group_file.head()
```


```python
#Add bins to file
file["Age_Group"] = pd.cut(file["Age"], Bins, labels=Group_names)
file.head()
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
      <th>Age</th>
      <th>Gender</th>
      <th>Item ID</th>
      <th>Item Name</th>
      <th>Price</th>
      <th>SN</th>
      <th>Age_Group</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>38</td>
      <td>Male</td>
      <td>165</td>
      <td>Bone Crushing Silver Skewer</td>
      <td>3.37</td>
      <td>Aelalis34</td>
      <td>35-39</td>
    </tr>
    <tr>
      <th>1</th>
      <td>21</td>
      <td>Male</td>
      <td>119</td>
      <td>Stormbringer, Dark Blade of Ending Misery</td>
      <td>2.32</td>
      <td>Eolo46</td>
      <td>20-24</td>
    </tr>
    <tr>
      <th>2</th>
      <td>34</td>
      <td>Male</td>
      <td>174</td>
      <td>Primitive Blade</td>
      <td>2.46</td>
      <td>Assastnya25</td>
      <td>30-34</td>
    </tr>
    <tr>
      <th>3</th>
      <td>21</td>
      <td>Male</td>
      <td>92</td>
      <td>Final Critic</td>
      <td>1.36</td>
      <td>Pheusrical25</td>
      <td>20-24</td>
    </tr>
    <tr>
      <th>4</th>
      <td>23</td>
      <td>Male</td>
      <td>63</td>
      <td>Stormfury Mace</td>
      <td>1.27</td>
      <td>Aela59</td>
      <td>20-24</td>
    </tr>
  </tbody>
</table>
</div>




```python
#file2.reset_index(inplace=True)
file.columns=["Age","Gender","Item ID","Item Name","Price","SN","Age_Group"]
file.reset_index(inplace=True)
```


```python
#Analysis by Age
#Purchase count by age group
Count_by_Age = pd.DataFrame(file.groupby('Age_Group')['SN'].count())
Count_by_Age.reset_index(inplace=True)
Count_by_Age.columns=["Age_Group","Purchase Count"]
#Average Purchase Price
Avg_by_Age = pd.DataFrame(file.groupby('Age_Group')['Price'].mean())
Avg_by_Age.reset_index(inplace=True)
Avg_by_Age.columns=["Age_Group","Average Price"]
#Total Purchase Value
Ttl_by_Age = pd.DataFrame(file.groupby("Age_Group")["Price"].sum())
Ttl_by_Age.reset_index(inplace=True)
Ttl_by_Age.columns=["Age_Group","Total Purchase"]
#Normalized values
Normalized_Age = (pd.DataFrame(file.groupby("Age_Group")["Price"].sum()))/Age_Table["Age"].count()
Normalized_Age.reset_index(inplace=True)
Normalized_Age.columns=["Age_Group","Normalized Values"]
# Create a new table consolidating above calculations
age_merge_table1 = pd.merge(Count_by_Age, Avg_by_Age, on="Age_Group")
age_merge_table2 = pd.merge(age_merge_table1, Ttl_by_Age, on="Age_Group")
age_merge_table = pd.merge(age_merge_table2, Normalized_Age, on="Age_Group")
age_merge_table
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
      <th>Age_Group</th>
      <th>Purchase Count</th>
      <th>Average Price</th>
      <th>Total Purchase</th>
      <th>Normalized Values</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>&lt;10</td>
      <td>28</td>
      <td>2.980714</td>
      <td>83.46</td>
      <td>0.145654</td>
    </tr>
    <tr>
      <th>1</th>
      <td>10-14</td>
      <td>35</td>
      <td>2.770000</td>
      <td>96.95</td>
      <td>0.169197</td>
    </tr>
    <tr>
      <th>2</th>
      <td>15-19</td>
      <td>133</td>
      <td>2.905414</td>
      <td>386.42</td>
      <td>0.674380</td>
    </tr>
    <tr>
      <th>3</th>
      <td>20-24</td>
      <td>336</td>
      <td>2.913006</td>
      <td>978.77</td>
      <td>1.708150</td>
    </tr>
    <tr>
      <th>4</th>
      <td>25-29</td>
      <td>125</td>
      <td>2.962640</td>
      <td>370.33</td>
      <td>0.646300</td>
    </tr>
    <tr>
      <th>5</th>
      <td>30-34</td>
      <td>64</td>
      <td>3.082031</td>
      <td>197.25</td>
      <td>0.344241</td>
    </tr>
    <tr>
      <th>6</th>
      <td>35-39</td>
      <td>42</td>
      <td>2.842857</td>
      <td>119.40</td>
      <td>0.208377</td>
    </tr>
    <tr>
      <th>7</th>
      <td>40-44</td>
      <td>16</td>
      <td>3.189375</td>
      <td>51.03</td>
      <td>0.089058</td>
    </tr>
    <tr>
      <th>8</th>
      <td>45-49</td>
      <td>1</td>
      <td>2.720000</td>
      <td>2.72</td>
      <td>0.004747</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Top Spenders
Count_by_User = pd.DataFrame(file.groupby('SN')['Item ID'].count())
Count_by_User.reset_index(inplace=True)
Count_by_User.columns=["SN","Purchase Count"]
#Count_by_User.head()
#Avg Price
Avg_by_User = pd.DataFrame(file.groupby('SN')['Price'].mean())
Avg_by_User.reset_index(inplace=True)
Avg_by_User.columns=["SN","Average Price"]
#Total Purchase Value
Ttl_by_User = pd.DataFrame(file.groupby("SN")["Price"].sum())
Ttl_by_User.reset_index(inplace=True)
Ttl_by_User.columns=["SN","Total Purchase"]
#Ttl_by_User
# Create a new table consolidating above calculations
user_merge_table1 = pd.merge(Count_by_User, Avg_by_User, on="SN")
user_merge_table = pd.merge(user_merge_table1, Ttl_by_User, on="SN")
#user_merge_table.head()
```


```python
#Show top 5 spenders
user_merge_table.nlargest(5,'Total Purchase')
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
      <th>SN</th>
      <th>Purchase Count</th>
      <th>Average Price</th>
      <th>Total Purchase</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>538</th>
      <td>Undirrala66</td>
      <td>5</td>
      <td>3.412000</td>
      <td>17.06</td>
    </tr>
    <tr>
      <th>428</th>
      <td>Saedue76</td>
      <td>4</td>
      <td>3.390000</td>
      <td>13.56</td>
    </tr>
    <tr>
      <th>354</th>
      <td>Mindimnya67</td>
      <td>4</td>
      <td>3.185000</td>
      <td>12.74</td>
    </tr>
    <tr>
      <th>181</th>
      <td>Haellysu29</td>
      <td>3</td>
      <td>4.243333</td>
      <td>12.73</td>
    </tr>
    <tr>
      <th>120</th>
      <td>Eoda93</td>
      <td>3</td>
      <td>3.860000</td>
      <td>11.58</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Item ID and Item Name Key
ID_key = pd.DataFrame(file.groupby('Item Name')['Item ID'].unique())
ID_key.reset_index(inplace=True)
ID_key.columns=["Item Name","Item ID"]
#ID_key.head()
```


```python
#Top Items: 
Count_by_Item = pd.DataFrame(file.groupby('Item Name')['Item ID'].count())
Count_by_Item.reset_index(inplace=True)
Count_by_Item.columns=["Item Name","Purchase Count"]
#Count_by_User.head()
#Avg Price
Avg_by_Item = pd.DataFrame(file.groupby('Item Name')['Price'].mean())
Avg_by_Item.reset_index(inplace=True)
Avg_by_Item.columns=["Item Name","Average Price"]
#Total Purchase Value
Ttl_by_Item = pd.DataFrame(file.groupby("Item Name")["Price"].sum())
Ttl_by_Item.reset_index(inplace=True)
Ttl_by_Item.columns=["Item Name","Total Purchase"]
#Ttl_by_User
# Create a new table consolidating above calculations
item_merge_table1 = pd.merge(Count_by_Item, Avg_by_Item, on="Item Name")
item_merge_table2 = pd.merge(item_merge_table1, ID_key, on="Item Name")
item_merge_table = pd.merge(item_merge_table2, Ttl_by_Item, on="Item Name")
item_merge_table = item_merge_table[['Item ID','Item Name', 'Purchase Count', 'Average Price', 'Total Purchase']]
#item_merge_table.head()
```


```python
#Show top 5 items by purchase count
item_merge_table.nlargest(5,'Purchase Count')
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
      <th>Item ID</th>
      <th>Item Name</th>
      <th>Purchase Count</th>
      <th>Average Price</th>
      <th>Total Purchase</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>56</th>
      <td>[92, 101]</td>
      <td>Final Critic</td>
      <td>14</td>
      <td>2.757143</td>
      <td>38.60</td>
    </tr>
    <tr>
      <th>8</th>
      <td>[84]</td>
      <td>Arcane Gem</td>
      <td>11</td>
      <td>2.230000</td>
      <td>24.53</td>
    </tr>
    <tr>
      <th>11</th>
      <td>[39]</td>
      <td>Betrayal, Whisper of Grieving Widows</td>
      <td>11</td>
      <td>2.350000</td>
      <td>25.85</td>
    </tr>
    <tr>
      <th>137</th>
      <td>[30, 180]</td>
      <td>Stormcaller</td>
      <td>10</td>
      <td>3.465000</td>
      <td>34.65</td>
    </tr>
    <tr>
      <th>112</th>
      <td>[34]</td>
      <td>Retribution Axe</td>
      <td>9</td>
      <td>4.140000</td>
      <td>37.26</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Show top 5 items by sales volume
item_merge_table.nlargest(5,'Total Purchase')
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
      <th>Item ID</th>
      <th>Item Name</th>
      <th>Purchase Count</th>
      <th>Average Price</th>
      <th>Total Purchase</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>56</th>
      <td>[92, 101]</td>
      <td>Final Critic</td>
      <td>14</td>
      <td>2.757143</td>
      <td>38.60</td>
    </tr>
    <tr>
      <th>112</th>
      <td>[34]</td>
      <td>Retribution Axe</td>
      <td>9</td>
      <td>4.140000</td>
      <td>37.26</td>
    </tr>
    <tr>
      <th>137</th>
      <td>[30, 180]</td>
      <td>Stormcaller</td>
      <td>10</td>
      <td>3.465000</td>
      <td>34.65</td>
    </tr>
    <tr>
      <th>132</th>
      <td>[115]</td>
      <td>Spectral Diamond Doomblade</td>
      <td>7</td>
      <td>4.250000</td>
      <td>29.75</td>
    </tr>
    <tr>
      <th>96</th>
      <td>[32]</td>
      <td>Orenmir</td>
      <td>6</td>
      <td>4.950000</td>
      <td>29.70</td>
    </tr>
  </tbody>
</table>
</div>


