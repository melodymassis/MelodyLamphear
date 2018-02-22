
##  Pyber

**Observed Trends**
* Urban areas have a higher concentration of drivers and fare counts, making up 63% of total revenue. 
* However, 30% of all fares come from suburban areas, where only 19% of all drivers are located.
* Most common fare prices hover around 22 and 28 dollars in Urban areas, and between 28 and 33 dollars in sububan areas.


```python
import pandas as pd
import matplotlib.pyplot as plt
import statistics
import os
import seaborn as sns
```


```python
#Read csv file for city data
csvpath = os.path.join("city_data.csv")
city = pd.read_csv(csvpath)
city.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>city</th>
      <th>driver_count</th>
      <th>type</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Kelseyland</td>
      <td>63</td>
      <td>Urban</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Nguyenbury</td>
      <td>8</td>
      <td>Urban</td>
    </tr>
    <tr>
      <th>2</th>
      <td>East Douglas</td>
      <td>12</td>
      <td>Urban</td>
    </tr>
    <tr>
      <th>3</th>
      <td>West Dawnfurt</td>
      <td>34</td>
      <td>Urban</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Rodriguezburgh</td>
      <td>52</td>
      <td>Urban</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Group by city/type to aggregate driver_count (to remove driver_count duplicate)
city_total = pd.DataFrame(city.groupby(['city','type'], as_index=True)['driver_count'].sum())
city_total.reset_index(inplace=True)
city_total.columns=['city','type','driver_count']
#city_total.head()
```


```python
#Read csv file for ride data
csv_ride = os.path.join("ride_data.csv")
rides = pd.read_csv(csv_ride)
rides.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>city</th>
      <th>date</th>
      <th>fare</th>
      <th>ride_id</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Sarabury</td>
      <td>2016-01-16 13:49:27</td>
      <td>38.35</td>
      <td>5403689035038</td>
    </tr>
    <tr>
      <th>1</th>
      <td>South Roy</td>
      <td>2016-01-02 18:42:34</td>
      <td>17.49</td>
      <td>4036272335942</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Wiseborough</td>
      <td>2016-01-21 17:35:29</td>
      <td>44.18</td>
      <td>3645042422587</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Spencertown</td>
      <td>2016-07-31 14:53:22</td>
      <td>6.87</td>
      <td>2242596575892</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Nguyenbury</td>
      <td>2016-07-09 04:42:44</td>
      <td>6.28</td>
      <td>1543057793673</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Calc avg fare per city and total number of rides
avg_fare = pd.DataFrame(rides.groupby('city')['fare'].mean())
avg_fare.reset_index(inplace=True)
avg_fare.columns=['city','avg_fare']
fare_count = pd.DataFrame(rides.groupby('city')['ride_id'].count())
fare_count.reset_index(inplace=True)
fare_count.columns=['city','fare_count']
ride_total = pd.merge(avg_fare, fare_count, on="city",how='left')
#ride_total.head()
```


```python
#Merge tables
combined_table = pd.merge(ride_total, city_total, on="city", how="left")
combined_table.columns=['city', 'avg_fare', 'fare_count', 'type', 'driver_count']
combined_table.head()
```




<div>
<style>
    .dataframe thead tr:only-child th {
        text-align: right;
    }

    .dataframe thead th {
        text-align: left;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>city</th>
      <th>avg_fare</th>
      <th>fare_count</th>
      <th>type</th>
      <th>driver_count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Alvarezhaven</td>
      <td>23.928710</td>
      <td>31</td>
      <td>Urban</td>
      <td>21</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Alyssaberg</td>
      <td>20.609615</td>
      <td>26</td>
      <td>Urban</td>
      <td>67</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Anitamouth</td>
      <td>37.315556</td>
      <td>9</td>
      <td>Suburban</td>
      <td>16</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Antoniomouth</td>
      <td>23.625000</td>
      <td>22</td>
      <td>Urban</td>
      <td>21</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Aprilchester</td>
      <td>21.981579</td>
      <td>19</td>
      <td>Urban</td>
      <td>49</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Create color coding for type
colors = {'type': ['Urban', 'Suburban', 'Rural'], 'color': ['lightblue','coral','gold']}

#Convert to color df to merge into combined_table df
colors_df = pd.DataFrame(colors)
colors_df.reset_index(inplace=False)
colors_df.columns=['color','type']
#colors_df
```


```python
#Merge into final table to create scatter plot
combo_color = pd.merge(combined_table, colors_df, on="type", how="left")
#combo_color.head()
```


```python
#Create scatter plot
plt.figure(figsize=(12,8))
sct = plt.scatter(combo_color['fare_count'], 
                  combo_color['avg_fare'], 
                  s=combo_color['driver_count']*20,
                  c=combo_color['color'],
                  alpha=0.8, 
                  linewidths=2,
                  edgecolors='grey')
plt.xlabel("Number of rides per city", fontsize='large')
plt.ylabel("Average Fare per city", fontsize='large')
plt.title("Pyber Ride Share Data Analysis 2018")
plt.text(40, 45, "Circle size correlates to\ndriver count per city", 
         horizontalalignment='left', 
         size='large', color='black', 
         weight='bold')

plt.legend(combo_color['type'], title='Location Type', fancybox=True, shadow=True, borderpad=1)
plt.grid(True)
plt.show()
```


![png](output_10_0.png)



```python
#Linear Regression:  Fare count vs. Avg Fare by location type
g = sns.lmplot(x="fare_count", y="avg_fare", hue= "type", size=5,
               truncate=True, data=combo_color)
plt.title("Fare count vs. Average Fare Price by location type")
plt.show()
```


![png](output_11_0.png)



```python
#Pie Charts**
#Create combined table to extract required data
total_fare = pd.DataFrame(rides.groupby('city')['fare'].sum())
total_fare.reset_index(inplace=True)
total_fare.columns=['city','total_fare']
pie_total = pd.merge(total_fare, fare_count, on="city",how='left')

combined_pie_table = pd.merge(pie_total, city_total, on="city", how="left") 
#combined_pie_table.head()
```


```python
#Calc total
#Total Fares by City Type
ttl_fare = combined_pie_table['total_fare'].sum()
print('Total revenue: $', round(ttl_fare))

#Total Rides by City Type
ttl_rides = combined_pie_table['fare_count'].sum()
print('Total number of rides:', ttl_rides)

#Total Drivers by City Type
ttl_drivers = combined_pie_table['driver_count'].sum()
print('Total number of drivers:', ttl_drivers)
```

    Total revenue: $ 63651
    Total number of rides: 2375
    Total number of drivers: 3349



```python
#Calc % of total fare by city type
city_fare = round(pd.DataFrame(combined_pie_table.groupby('type')['total_fare'].sum()/ttl_fare*100),1)
#print(city_fare)
plt.pie(city_fare, labels=['Rural','Suburban','Urban'], shadow=0.4, autopct='%1.1f%%', startangle=90, explode=(0,0,0.1),
        colors=['coral','gold','lightblue'])
plt.title("% of Total fares by city type")
plt.show()
```


![png](output_14_0.png)



```python
#Calc % of total rides by city type
city_rides = round(pd.DataFrame(combined_pie_table.groupby('type')['fare_count'].sum()/ttl_rides*100),1)
#print(city_rides)
plt.pie(city_rides, labels=['Rural','Suburban','Urban'], shadow=0.4, autopct='%1.1f%%', startangle=90, explode=(0,0,0.1),
        colors=['coral','gold','lightblue'])
plt.title("% of Total rides by city type")
plt.show()
```


![png](output_15_0.png)



```python
#Calc % of total drivers by city type
type_drivers = round(pd.DataFrame(combined_pie_table.groupby('type')['driver_count'].sum()/ttl_drivers*100),1)
#print(type_drivers)
plt.pie(type_drivers, labels=['Rural','Suburban','Urban'], shadow=0.4, autopct='%1.1f%%', startangle=120, explode=(0.1,0,0.1),
        colors=['coral','gold','lightblue'])
plt.title("% of Total drivers by city type")
plt.show()
```


![png](output_16_0.png)

