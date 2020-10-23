# Здесь нужно:
#1 объединить все насчитанные признаки с основной частью;
#2 Обучить любую модель, на любом кол-ве данных - качество не играет никакой роли 
# (пример можно поискать тут:https://www.kaggle.com/c/ashrae-energy-prediction/notebooks);
#3 Сохранить модель в pickle.
from catboost import CatBoostRegressor
import pandas as pd
from base_part import get_base_part
from feature1 import get_feature1
from feature2 import get_feature2
from sklearn.model_selection import train_test_split
import pickle


base_df = pd.read_feather('../data/base_part.fthr')
feature1 = pd.read_feather('../data/feature1.fthr')
feature2 = pd.read_feather('../data/feature2.fthr')
data = base_df.merge(feature1, how='left', on='building_id').merge(feature2, how='left', on='building_id')
data.dropna(inplace=True)
X, y = data.drop(columns='meter_reading'), data['meter_reading']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
model = CatBoostRegressor(task_type="GPU", devices='0:1', iterations=2000 )
model.fit(X_train, y_train)
pickle.dump(model, open('../data/model.pickle', 'wb'))