from flask import Flask, request, jsonify
from flask_cors import CORS
import pickle
import pandas as pd

app = Flask(__name__)
CORS(app)


path_to_utils = 'C:/Users/Dmitry/Documents/GitHub/data-science-projects/car_price/backend/utils/'
scaler = pickle.load(open(path_to_utils + 'scaler.pkl', 'rb'))
model = pickle.load(open(path_to_utils + 'catboost_model.pkl', 'rb'))


def translate_data(car):
    rename_dict = pickle.load(open(path_to_utils + 'rename_dict.pkl', 'rb'))
    car['drive_type'] = car['drive_type'].apply(lambda x: rename_dict[x])
    car['fuel_type'] = car['fuel_type'].apply(lambda x: rename_dict[x])

def one_hot_encoding(car):
    one_hot_cols = ['drive_type', 'fuel_type', 'transmission_type']
    result = car.drop(columns=one_hot_cols)

    for col in one_hot_cols:
        encoder = pickle.load(
            open(path_to_utils + f'{col}_one_hot.pkl', 'rb'))
        
        col_encoded = pd.DataFrame(encoder.transform(car[[col]]).toarray(
        ), columns=encoder.get_feature_names_out([col]))

        result = pd.concat((result, col_encoded), axis=1)

    return result

def target_encoding(car):
    target_encoded_cols = ['body_type', 'brand', 'model']

    for col in target_encoded_cols:
        encoder = pickle.load(
            open(path_to_utils + f'{col}_target.pkl', 'rb'))
        
        car[col] = encoder[car[col].values[0]]

def prepare_data(data):
    car = make_df(data)
    car.reset_index(drop=True, inplace=True)
    translate_data(car)
    target_encoding(car)
    return one_hot_encoding(car)

def make_df(data):
    prepared_data = [{
        'brand': data['brand'],
        'years_in_operation': data['yearsInUse'],
        'is_crashed': 1 if data['damaged'] else 0,
        'model': data['brand'] + ' ' + data['model'],
        'mileage': data['mileage'],
        'body_type': data['bodyType'],
        'drive_type': data['driveType'],
        'fuel_type': data['fuelType'],
        'engine_volume': data['engineCapacity'],
        'transmission_type': data['transmissionType'],
        'power': data['horsePower'],
    }]
    return pd.DataFrame(prepared_data)


@app.route('/api/predict', methods=['POST'])
def predict():
    data = request.json

    ready_data = prepare_data(data)

    data_scaled = scaler.transform(ready_data)
    price =int(model.predict(data_scaled)[0])

    return jsonify({'price': price}), 200


if __name__ == '__main__':
    app.run(debug=True)
