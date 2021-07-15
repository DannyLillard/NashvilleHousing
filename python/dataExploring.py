#  Author: Danny Lillard
#  Date: 6/24/2021
#  Desc: Just looking at the data in python, making sure all is good!

#importing our packages
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.preprocessing import StandardScaler
import seaborn as sns

df = pd.read_csv('../Database/cleanedDatabase/nashvilleClean1.csv', index_col=[0])

# There are several outliers at the top end, 
# this is expected with the housing market.

X = df.drop(['parcel_id', 'legal_reference', 'sale_date', 'property_address', 'owner_address', 'owner_name'], axis=1)

#Creating histograms of the numerical features.
ax = X.hist(figsize=(10,10))
plt.savefig('hist.pdf')

categorical_columns = X[['land_use',
'property_city', 'sold_as_vacant',
'owner_city', 'owner_state',
'tax_district']]

numerical_columns = X[['acreage', 'sale_price',
'land_value', 'building_value', 'year_built',
'bedrooms', 'full_bath', 'half_bath']]

#scaling the numerical data.
scaler = StandardScaler()
#Scale data then convert it to a dataframe
scaledNumericalFeatures = scaler.fit_transform(numerical_columns)
snf_df = pd.DataFrame(scaledNumericalFeatures, index=numerical_columns.index, columns=numerical_columns.columns)
#plot the scaled data on a dataplot.
ax = snf_df.plot(figsize = (18,5))
fig = ax.get_figure()
fig.savefig('varGraph.pdf')

#lets look at correlation.
#A few scatter plots here, looking for correlation with sale_price:
ax = X.plot.scatter(x='sale_price', y='acreage')
fig = ax.get_figure()
plt.savefig('priceVacreage.pdf')

ax = X.plot.scatter(x=['sale_price'], y=['year_built'])
fig = ax.get_figure()
plt.savefig('priceVyearBuilt.pdf')

ax = X.plot.scatter(x=['sale_price'], y=['bedrooms'])
fig = ax.get_figure()
plt.savefig('priceVbedrooms.pdf')

df_encoded = X
#Encoding the categorical data
for col_name in df_encoded.columns:
    if(df_encoded[col_name].dtype == object):
        df_encoded[col_name] = df_encoded[col_name].astype('category')
        df_encoded[col_name] = df_encoded[col_name].cat.codes

print(df_encoded.head())
#correlation matrix
corr = X.corr()
plt.figure(figsize=(12,8))
ax = sns.heatmap(corr, cmap='Blues', annot=True)
fig = ax.get_figure()
plt.savefig('heatmap.pdf')